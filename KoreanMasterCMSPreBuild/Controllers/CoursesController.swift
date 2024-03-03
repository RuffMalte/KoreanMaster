//
//  CoursesController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI
import Observation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@Observable
class CoursesController: ObservableObject {
	
	
	var isLoadingCourse: Bool = false
	
	init() {
		
	}
	
	func createCourse(course: Course) {
		let db = Firestore.firestore()
		let courseRef = db.collection("courses").document(course.getCourseComputedName())
		
		courseRef.setData(course.toFirebaseDocument()) { error in
			if let error = error {
				print("Error writing course document: \(error)")
				return
			}
			print("Course successfully written!")
			
			// Start a new batch
			let batch = db.batch()
			
			for lang in course.localizedLessons ?? [] {
				let localizedLessonInfoRef = courseRef.collection("Info").document(lang.language )
				// Add to batch
				batch.setData(lang.toInfo(), forDocument: localizedLessonInfoRef)
				
				let localizedLessonRef = courseRef.collection(lang.language )
				for page in lang.pages ?? [] {
					let pageRef = localizedLessonRef.document(page.pageTitle)
					// Add to batch
					batch.setData(page.toPage(), forDocument: pageRef)
				}
			}
			
			// Commit the batch
			batch.commit() { err in
				if let err = err {
					print("Error writing batch: \(err)")
				} else {
					print("Batch write succeeded.")
				}
			}
		}
	}
	
	
	func getCourseLocalizedInfoTEST(courseName: String, language: String, completion: @escaping (LocalizedLesson?) -> Void) {
		let db = Firestore.firestore()
		
		// Construct the path to the specific localized lesson info
		let infoRef = db.collection("courses").document(courseName).collection("Info").document(language)
		
		// Fetch the document
		infoRef.getDocument { (document, error) in
			if let document = document, document.exists {
				// Deserialize the data back into a LocalizedLesson object
				do {
					let localizedLesson = try document.data(as: LocalizedLesson.self)
					
					completion(localizedLesson)
				} catch let error {
					print("Error deserializing lesson: \(error)")
					completion(nil)
				}
			} else {
				print("Document does not exist or error fetching document: \(String(describing: error))")
				completion(nil)
			}
		}
	}
	//for user
	func getAllCoursesLocalized(sectionFilter: Int? = nil, language: String, completion: @escaping ([Course]) -> Void) {
		let db = Firestore.firestore()
		
		var query: Query = db.collection("courses")
		
		if let section = sectionFilter {
			query = query.whereField("section", isEqualTo: section)
		}
		
		query.getDocuments { (querySnapshot, error) in
			var courses: [Course] = []
			
			if let error = error {
				print("Error getting documents: \(error)")
				completion([])
				return
			}
			
			let group = DispatchGroup()
			
			for document in querySnapshot!.documents {
				do {
					let course = try document.data(as: Course.self)
					// For each course, fetch the localized lesson information.
					group.enter()
					
					let infoRef = db.collection("courses").document(course.getCourseComputedName()).collection("Info").document(language)
					infoRef.getDocument { (doc, err) in
						if let doc = doc, doc.exists {
							do {
								let localizedLesson = try doc.data(as: LocalizedLesson.self)
								course.localizedLessons = [localizedLesson]
							} catch let decodeError {
								print("Error decoding localized lesson: \(decodeError)")
							}
						} else if let err = err {
							print("Error fetching localized lesson: \(err)")
						}
						group.leave()
					}
					
					courses.append(course)
					
				} catch let decodeError {
					print("Error deserializing course: \(decodeError)")
				}
			}
			
			group.notify(queue: .main) {
				completion(courses)
			}
		}
	}
	
	//for admin
	///When only getting a single Course add a single item in the language array, otherwise add all languages
	func getCourseFullDetail(courseName: String, languages: [CourseLanguage], completion: @escaping (Course?) -> Void) {
		self.isLoadingCourse = true
		
		let db = Firestore.firestore()
		let courseRef = db.collection("courses").document(courseName)
		
		courseRef.getDocument { (document, error) in
			self.isLoadingCourse = true
			if let document = document, document.exists {
				do {
					let course = try document.data(as: Course.self)
					course.localizedLessons = []  // Initialize the localizedLessons array
					
					let group = DispatchGroup()
					
					for lang in languages {
						group.enter() // Enter the group for each language
						
						let infoRef = courseRef.collection("Info").document(lang.language)
						infoRef.getDocument { (doc, err) in
							if let doc = doc, doc.exists {
								do {
									let localizedLesson = try doc.data(as: LocalizedLesson.self)
									localizedLesson.pages = [] // Initialize the pages array
									
									let localizedPageRef = courseRef.collection(lang.language)
									group.enter() // Enter the group for pages
									localizedPageRef.getDocuments { (querySnapshot, error) in
										if let querySnapshot = querySnapshot {
											for document in querySnapshot.documents {
												do {
													let page = try document.data(as: LessonPage.self)
													localizedLesson.pages?.append(page)
												} catch let decodeError {
													print("Error deserializing page: \(decodeError)")
												}
											}
										}
										course.localizedLessons?.append(localizedLesson)
										group.leave() // Leave the group for pages
									}
								} catch let decodeError {
									print("Error decoding localized lesson: \(decodeError)")
								}
							} else if let err = err {
								print("Error fetching localized lesson: \(err)")
							}
							group.leave() // Leave the group for each language
						}
					}
					
					// Once all asynchronous operations have finished, return the course
					group.notify(queue: .main) {
						completion(course)
						self.isLoadingCourse = false
					}
					
				} catch let decodeError {
					print("Error deserializing course: \(decodeError)")
					completion(nil)
				}
			} else {
				print("Document does not exist or error fetching document: \(String(describing: error))")
				completion(nil)
			}
		}
	}


	func saveCourse(course: Course) {
		let db = Firestore.firestore()
		let courseRef = db.collection("courses").document(course.getCourseComputedName())
		
		let batch = db.batch()
		
		// Set or update the main course document
		batch.setData(course.toFirebaseDocument(), forDocument: courseRef, merge: true)
		
		// Iterate through localized lessons and add them to the batch
		for localizedLesson in course.localizedLessons ?? []{
			let infoRef = courseRef.collection("Info").document(localizedLesson.language)
			batch.setData(localizedLesson.toInfo(), forDocument: infoRef)
			
			// Iterate through pages of each localized lesson and add them to the batch
			for page in localizedLesson.pages ?? []{
				let pageRef = courseRef.collection(localizedLesson.language).document(page.id)
				batch.setData(page.toPage(), forDocument: pageRef)
			}
		}
		
		// Commit the batch
		batch.commit { error in
			if let error = error {
				print("Error writing batch: \(error)")
			} else {
				print("Batch write succeeded.")
			}
		}
	}
	
}
