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
	
	private let dispatchGroup = DispatchGroup()
	private var encounteredError: Error?
	
	var isLoadingAllLessons = false
	var isLoadingSingleLesson = false
	
	private func fetchDetailsDocumentData<T: Decodable>(refGenerator: DocumentReferenceGenerator, forType type: DocumentReferenceGenerator.DocumentType, assignTo: @escaping (T?) -> Void) {
		dispatchGroup.enter()
		let detailDocRef = refGenerator.getDocumentRef(forType: type)
		detailDocRef.getDocument { (document, error) in
			defer { self.dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					let data = try document.data(as: T.self)
					assignTo(data)
				} catch {
					print("Error decoding \(type): \(error)")
					self.encounteredError = error
				}
			} else if let error = error {
				print("Error fetching document for \(type): \(error)")
				self.encounteredError = error
			}
		}
	}
	
	private func fetchSubcollection<T: Decodable>(refGenerator: DocumentReferenceGenerator, forDetail detailType: DocumentReferenceGenerator.DocumentType, subCollectionType: DocumentReferenceGenerator.CollectionType, assignTo: @escaping ([T]) -> Void) {
		dispatchGroup.enter()
		let subcollectionRef = refGenerator.getCollectionRef(forDetail: detailType, subCollection: subCollectionType)
		subcollectionRef.getDocuments { (snapshot, error) in
			defer { self.dispatchGroup.leave() }
			guard let documents = snapshot?.documents else {
				self.encounteredError = error
				return
			}
			let items: [T] = documents.compactMap { doc in
				return try? doc.data(as: T.self)
			}
			assignTo(items)
		}
	}
	
	private func deleteObsoleteDocuments<T: Identifiable>(
		refGenerator: DocumentReferenceGenerator,
		detailType: DocumentReferenceGenerator.DocumentType,
		subCollectionType: DocumentReferenceGenerator.CollectionType,
		updatedData: [T],
		completion: @escaping (Error?) -> Void) where T.ID == String {
			
			let subCollectionRef = refGenerator.getCollectionRef(forDetail: detailType, subCollection: subCollectionType)
			
			subCollectionRef.getDocuments { (snapshot, error) in
				guard let documents = snapshot?.documents else {
					completion(error)
					return
				}
				
				// Find out which documents need to be deleted
				let existingIds = documents.map { $0.documentID }
				let updatedIds = updatedData.map { $0.id }
				let idsToDelete = existingIds.filter { !updatedIds.contains($0) }
				
				// Delete obsolete documents
				for id in idsToDelete {
					subCollectionRef.document(id).delete { error in
						if let error = error {
							completion(error)
							return
						}
					}
				}
				
				// Completion with nil error if all deletions (if any) were initiated successfully
				completion(nil)
			}
		}

	
	///if the lesson already exists, it will be overwritten, otherwise a new lesson will be created
	func SaveLesson(lesson: Lesson, language: String, completion: @escaping (Bool) -> Void) {
		let db = Firestore.firestore()
		let batch = db.batch()
		
		// Get document references from a separate function or class
		let refGenerator = DocumentReferenceGenerator(lessonName: lesson.lessonInfo.lessonName, language: language)
		
		do {
			batch.setData([
				"LessonName":lesson.lessonInfo.lessonName,
				"id":lesson.id
			], forDocument: refGenerator.getLessonsCollectionRef().document(lesson.lessonInfo.lessonName))
			
			// Set info
			let lessonInfoRef = refGenerator.getDocumentRef(forType: .info)
			batch.setData(lesson.lessonInfo.toFirebase(), forDocument: lessonInfoRef)
			
			// Set tags
			let lessonTagsRef = refGenerator.getDocumentRef(forType: .tags)
			try batch.setData(from: lesson.lessonTag, forDocument: lessonTagsRef)
			
			// Set goals
			if let lessonGoal = lesson.lessonGoal {
				let lessonGoalRef = refGenerator.getDocumentRef(forType: .goal)
				batch.setData(lessonGoal.toFirebase(), forDocument: lessonGoalRef)
				
				// Set lessonGoals Example
				if let lessonGoalExamples = lessonGoal.lessonGoalExamples {
					let examplesCollectionRef = refGenerator.getCollectionRef(forDetail: .goal, subCollection: .goalsExamples)
					
					// Delete obsolete documents
					self.deleteObsoleteDocuments(refGenerator: refGenerator, detailType: .goal, subCollectionType: .goalsExamples, updatedData: lessonGoalExamples) { error in
						if let error = error {
							print("Error deleting obsolete lessonGoalExamples: \(error)")
							return
						}
					}
					
					// Add new documents
					for example in lessonGoalExamples {
						let exampleRef = examplesCollectionRef.document(example.id)
						try batch.setData(from: example, forDocument: exampleRef)
					}
				}
			}
			
			// Set newLessonVocabUsed
			if let newLessonVocabUsed = lesson.newLessonVocabUsed {
				let newLessonVocabUsedRef = refGenerator.getDocumentRef(forType: .vocabUsed)
				try batch.setData(from: newLessonVocabUsed, forDocument: newLessonVocabUsedRef)
			}
			
			// Set LessonGrammar
			if let grammar = lesson.lessonGrammar {
				let lessonGrammarRef = refGenerator.getDocumentRef(forType: .grammar)
				batch.setData(grammar.toFirebase(), forDocument: lessonGrammarRef)
				
				// Set LessonGrammar Pages
				if let grammarPages = grammar.LessonGrammarPages {
					let grammarPagesCollectionRef = refGenerator.getCollectionRef(forDetail: .grammar, subCollection: .grammarPages)
					
					// Delete obsolete grammar pages
					self.deleteObsoleteDocuments(refGenerator: refGenerator, detailType: .grammar, subCollectionType: .grammarPages, updatedData: grammarPages) { error in
						if let error = error {
							print("Error deleting obsolete grammar pages: \(error)")
							return
						}
					}
					
					// Add new grammar pages
					for page in grammarPages {
						let pageRef = grammarPagesCollectionRef.document(page.id)
						try batch.setData(from: page, forDocument: pageRef)
					}
				}
			}
			
			// Set lessonPractice
			if let lessonPractice = lesson.lessonPractice {
				let lessonPracticeRef = refGenerator.getDocumentRef(forType: .practice)
				batch.setData(lessonPractice.toFirebase(), forDocument: lessonPracticeRef)
				
				// Set lessonPractice multipleChoice
				if let multipleChoices = lessonPractice.mulitpleChoice {
					let multipleChoiceCollectionRef = refGenerator.getCollectionRef(forDetail: .practice, subCollection: .practiceMultipleChoice)
					
					// Delete obsolete multipleChoice
					self.deleteObsoleteDocuments(refGenerator: refGenerator, detailType: .practice, subCollectionType: .practiceMultipleChoice, updatedData: multipleChoices) { error in
						if error != nil {
							print("Error deleting obsolete multipleChoice: \(String(describing: error))")
							return
						}
					}
					
					// Add new multipleChoice
					for multipleChoice in multipleChoices {
						let choiceRef = multipleChoiceCollectionRef.document(multipleChoice.id)
						try batch.setData(from: multipleChoice, forDocument: choiceRef)
					}
				}
				
				// Set lessonPractice sentenceBuilding
				if let sentenceBuildings = lessonPractice.sentenceBuilding {
					let sentenceBuildingCollectionRef = refGenerator.getCollectionRef(forDetail: .practice, subCollection: .practiceSentenceBuilding)
					
					// Delete obsolete sentenceBuilding
					self.deleteObsoleteDocuments(refGenerator: refGenerator, detailType: .practice, subCollectionType: .practiceSentenceBuilding, updatedData: sentenceBuildings) { error in
						if let error = error {
							print("Error deleting obsolete sentenceBuilding: \(error)")
							return
						}
					}
					
					// Add new sentenceBuilding
					for sentenceBuilding in sentenceBuildings {
						let sentenceRef = sentenceBuildingCollectionRef.document(sentenceBuilding.id)
						try batch.setData(from: sentenceBuilding, forDocument: sentenceRef)
					}
				}
			}
			
			// Set lessonCultureReferences
			if let lessonCultureReferences = lesson.lessonCultureReferences {
				let lessonCultureReferencesRef = refGenerator.getDocumentRef(forType: .cultureReferences)
				batch.setData(lessonCultureReferences.toFirebase(), forDocument: lessonCultureReferencesRef)
				
				// Set lessonCultureReferences songs
				if let songs = lessonCultureReferences.songs {
					let songsCollectionRef = refGenerator.getCollectionRef(forDetail: .cultureReferences, subCollection: .cultureSongs)
					
					// Delete obsolete songs
					self.deleteObsoleteDocuments(refGenerator: refGenerator, detailType: .cultureReferences, subCollectionType: .cultureSongs, updatedData: songs) { error in
						if let error = error {
							print("Error deleting obsolete songs: \(error)")
							return
						}
					}
					
					// Add new songs
					for song in songs {
						let songRef = songsCollectionRef.document(song.id)
						try batch.setData(from: song, forDocument: songRef)
					}
				}
			}
			
			// Finally, commit the batch
			batch.commit { error in
				if let error = error {
					print("Error writing batch to Firestore: \(error)")
					completion(false)
				} else {
					completion(true)
				}
			}
		} catch {
			print("Error writing lesson to Firestore: \(error)")
			completion(false)
		}
	}
	
	func getFullLesson(lessonName: String, language: String, completion: @escaping (Lesson?, Error?) -> Void) {
		let refGenerator = DocumentReferenceGenerator(lessonName: lessonName, language: language)
		let lesson = Lesson.empty
		self.isLoadingSingleLesson = true
		self.encounteredError = nil
		
		
		
		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .info) { (info: LessonInfo?) in
			if let info = info {
				lesson.lessonInfo = info
			}
		}

		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .tags) { (tags: LessonTag?) in
			if let tags = tags {
				lesson.lessonTag = tags
			}
		}
		
		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .vocabUsed) { (newVocab: NewLessonVocabUsed?) in
			if let newVocab = newVocab {
				lesson.newLessonVocabUsed = newVocab
			}
		}
		
		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .goal, assignTo: { (goal: LessonGoal?) in
			lesson.lessonGoal = goal
			if let _ = goal {
				self.fetchSubcollection(refGenerator: refGenerator, forDetail: .goal, subCollectionType: .goalsExamples, assignTo: { examples in
					lesson.lessonGoal?.lessonGoalExamples = examples
				})
			}
		})
		
		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .grammar, assignTo: { (grammar: LessonGrammar?) in
			lesson.lessonGrammar = grammar
			if let _ = grammar {
				self.fetchSubcollection(refGenerator: refGenerator, forDetail: .grammar, subCollectionType: .grammarPages, assignTo: { pages in
					lesson.lessonGrammar?.LessonGrammarPages = pages
				})
			}
		})
		
		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .practice, assignTo: { (practice: LessonPractice?) in
			lesson.lessonPractice = practice
			if let _ = practice {
				self.fetchSubcollection(refGenerator: refGenerator, forDetail: .practice, subCollectionType: .practiceMultipleChoice, assignTo: { mc in
					lesson.lessonPractice?.mulitpleChoice = mc
				})
				self.fetchSubcollection(refGenerator: refGenerator, forDetail: .practice, subCollectionType: .practiceSentenceBuilding, assignTo: { sb in
					lesson.lessonPractice?.sentenceBuilding = sb
				})
			}
		})
		
		fetchDetailsDocumentData(refGenerator: refGenerator, forType: .cultureReferences, assignTo: { (cultureRefs: LessonCultureReference?) in
			lesson.lessonCultureReferences = cultureRefs
			if let _ = cultureRefs {
				self.fetchSubcollection(refGenerator: refGenerator, forDetail: .cultureReferences, subCollectionType: .cultureSongs, assignTo: { songs in
					lesson.lessonCultureReferences?.songs = songs
				})
			}
		})
		
		// Once all asynchronous tasks are complete, finish the operation
		dispatchGroup.notify(queue: .main) {
			if let error = self.encounteredError {
				completion(nil, error)
			} else {
				completion(lesson, nil)
			}
			self.isLoadingSingleLesson = false
		}
	}

  
	
	private func fetchDetails(refGenerator: DocumentReferenceGenerator, completion: @escaping (Lesson?, Error?) -> Void) {
		let dispatchGroup = DispatchGroup()
		let lesson = Lesson.empty
		
		dispatchGroup.enter()
		self.fetchDetailsDocumentData(refGenerator: refGenerator, forType: .info) { (info: LessonInfo?) in
			if let info = info {
				lesson.lessonInfo = info
			}
			dispatchGroup.leave()
		}
		
		dispatchGroup.enter()
		self.fetchDetailsDocumentData(refGenerator: refGenerator, forType: .tags) { (tags: LessonTag?) in
			if let tags = tags {
				lesson.lessonTag = tags
			}
			dispatchGroup.leave()
		}
		
		// Wait for all data fetching to complete
		dispatchGroup.notify(queue: .main) {
			if let error = self.encounteredError {
				completion(nil, error)
			} else {
				completion(lesson, nil)
			}
		}
	}
	
	func getAllLessons(language: String, completion: @escaping ([Lesson], Error?) -> Void) {
		let languageRefGenerator = DocumentReferenceGenerator(language: language)
		let lessonsCollectionRef = languageRefGenerator.getLessonsCollectionRef()
		isLoadingAllLessons = true
		
		lessonsCollectionRef.getDocuments { snapshot, error in
			var lessons: [Lesson] = []
			
			guard let snapshot = snapshot else {
				self.isLoadingAllLessons = false
				completion([], error)
				return
			}
			
			for document in snapshot.documents {
				let refGenerator = DocumentReferenceGenerator(lessonName: document.documentID, language: language)
				
				let newLesson = Lesson.new
					
				self.fetchDetailsDocumentData(refGenerator: refGenerator, forType: .info) { (info: LessonInfo?) in
					if let info = info {
						newLesson.lessonInfo = info
					}
				}
				
				self.fetchDetailsDocumentData(refGenerator: refGenerator, forType: .tags) { (tags: LessonTag?) in
					if let tags = tags {
						newLesson.lessonTag = tags
					}
				}
				
			
				lessons.append(newLesson)
			}

			self.isLoadingAllLessons = false
			completion(lessons, nil)
		}
	
	}
	
	func deleteLesson(lesson: Lesson, language: String, completion: @escaping (Bool) -> Void) {
		let refGenerator = DocumentReferenceGenerator(lessonName: lesson.lessonInfo.lessonName, language: language)
		
		
		let mainLessonPath = refGenerator.getLessonsCollectionRef()
		
		mainLessonPath.document(lesson.lessonInfo.lessonName).delete() { error in
			if let error = error {
				print("Error removing document: \(error)")
				completion(false)
			} else {
				completion(true)
			}
		}
		
		
	}
	
	
}


