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
	
	func addNewLesson(lesson: Lesson, language: String, completion: @escaping (Bool) -> Void) {
		let db = Firestore.firestore()
		let batch = db.batch()
		
		// Get document references from a separate function or class
		let refGenerator = DocumentReferenceGenerator(lessonName: lesson.lessonInfo.lessonName, language: language)
		
		do {
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
				if let lessonGoalExample = lesson.lessonGoal?.lessonGoalExamples {
					for example in lessonGoalExample {
						let exampleRef = refGenerator.getNewDocumentRef(forCollection: .goalsExamples)
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
				let LessonGrammarRef = refGenerator.getDocumentRef(forType: .grammar)
				batch.setData(grammar.toFirebase(), forDocument: LessonGrammarRef)
				
				// Set LessonGrammar Pages
				if let grammarPages = grammar.LessonGrammarPages {
					for page in grammarPages {
						let pageRef = refGenerator.getNewDocumentRef(forCollection: .grammarPages)
						try batch.setData(from: page, forDocument: pageRef)
					}
				}
			}
			
			// Set lessonPractice
			if let lessonPractice = lesson.lessonPractice {
				let lessonPracticeRef = refGenerator.getDocumentRef(forType: .practice)
				batch.setData(lessonPractice.toFirebase(), forDocument: lessonPracticeRef)
				
				// Set lessonPractice multipleChoice
				if let mulitpleChoice = lessonPractice.mulitpleChoice {
					for multipleChoice in mulitpleChoice {
						let choiceRef = refGenerator.getNewDocumentRef(forCollection: .practiceMultipleChoice)
						try batch.setData(from: multipleChoice, forDocument: choiceRef)
					}
				}
				
				// Set lessonPractice sentenceBuilding
				if let sentenceBuilding = lessonPractice.sentenceBuilding {
					for sentenceBuilding in sentenceBuilding {
						let sentenceRef = refGenerator.getNewDocumentRef(forCollection: .practiceSentenceBuilding)
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
					for song in songs {
						let songRef = refGenerator.getNewDocumentRef(forCollection: .cultureSongs)
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

		let dispatchGroup = DispatchGroup()
		
		let lesson = Lesson.detailExample
		
		var encounteredError: Error?
		
		// Info
		dispatchGroup.enter()
		let lessonInfoRef = refGenerator.getDocumentRef(forType: .info)
		lessonInfoRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.lessonInfo = try document.data(as: LessonInfo.self)
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// Tags
		dispatchGroup.enter()
		let lessonTagsRef = refGenerator.getDocumentRef(forType: .tags)
		lessonTagsRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.lessonTag = try document.data(as: LessonTag.self)
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// Goals
		dispatchGroup.enter()
		let lessonGoalRef = refGenerator.getDocumentRef(forType: .goal)
		lessonGoalRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.lessonGoal = try document.data(as: LessonGoal.self)
										
					// Now fetch the goalsExamples subcollection
					dispatchGroup.enter()  // Enter again for the subcollection
					let goalsExamplesRef = refGenerator.getCollectionRef(forDocumentRef: lessonGoalRef, type: .goalsExamples)
					goalsExamplesRef.getDocuments { (querySnapshot, error) in
						defer { dispatchGroup.leave() }
						if let querySnapshot = querySnapshot {
							var examples = [LessonGoalExample]()
							for document in querySnapshot.documents {
								if let example = try? document.data(as: LessonGoalExample.self) {
									examples.append(example)
								}
							}
							lesson.lessonGoal?.lessonGoalExamples = examples
						} else if let error = error {
							encounteredError = error
						}
					}
					
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// VocabUsed
		dispatchGroup.enter()
		let vocabUsedRef = refGenerator.getDocumentRef(forType: .vocabUsed)
		vocabUsedRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.newLessonVocabUsed = try document.data(as: NewLessonVocabUsed.self)
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// Grammar
		dispatchGroup.enter()
		let grammarRef = refGenerator.getDocumentRef(forType: .grammar)
		grammarRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.lessonGrammar = try document.data(as: LessonGrammar.self)
					
					// Fetch the LessonGrammarPages subcollection
					dispatchGroup.enter() // Enter again for the subcollection
					let pagesRef = refGenerator.getCollectionRef(forDocumentRef: grammarRef, type: .grammarPages)
					pagesRef.getDocuments { (querySnapshot, error) in
						defer { dispatchGroup.leave() }
						if let querySnapshot = querySnapshot {
							var pages = [LessonGrammarPage]()
							for document in querySnapshot.documents {
								if let page = try? document.data(as: LessonGrammarPage.self) {
									pages.append(page)
								}
							}
							lesson.lessonGrammar?.LessonGrammarPages = pages
						} else if let error = error {
							encounteredError = error
						}
					}
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// Practice
		dispatchGroup.enter()
		let practiceRef = refGenerator.getDocumentRef(forType: .practice)
		practiceRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.lessonPractice = try document.data(as: LessonPractice.self)
					
					
					// Fetch the multipleChoice subcollection
					dispatchGroup.enter()
					let multipleChoiceRef = refGenerator.getCollectionRef(forDocumentRef: practiceRef, type: .practiceMultipleChoice)
					multipleChoiceRef.getDocuments { (querySnapshot, error) in
						defer { dispatchGroup.leave() }
						if let querySnapshot = querySnapshot {
							var multipleChoices = [LessonpracticeMultipleChoice]()
							for document in querySnapshot.documents {
								if let choice = try? document.data(as: LessonpracticeMultipleChoice.self) {
									multipleChoices.append(choice)
								}
							}
							lesson.lessonPractice?.mulitpleChoice = multipleChoices
						} else if let error = error {
							encounteredError = error
						}
					}
					
					// Fetch the sentenceBuilding subcollection
					dispatchGroup.enter()
					let sentenceBuildingRef = refGenerator.getCollectionRef(forDocumentRef: practiceRef, type: .practiceSentenceBuilding)
					sentenceBuildingRef.getDocuments { (querySnapshot, error) in
						defer { dispatchGroup.leave() }
						if let querySnapshot = querySnapshot {
							var sentenceBuildings = [LessonpracticeSentenceBuilding]()
							for document in querySnapshot.documents {
								if let sentence = try? document.data(as: LessonpracticeSentenceBuilding.self) {
									sentenceBuildings.append(sentence)
								}
							}
							lesson.lessonPractice?.sentenceBuilding = sentenceBuildings
						} else if let error = error {
							encounteredError = error
						}
					}
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// CultureReferences
		dispatchGroup.enter()
		let cultureRef = refGenerator.getDocumentRef(forType: .cultureReferences)
		cultureRef.getDocument { (document, error) in
			defer { dispatchGroup.leave() }
			if let document = document, document.exists {
				do {
					lesson.lessonCultureReferences = try document.data(as: LessonCultureReference.self)
					
					// Fetch the songs subcollection
					dispatchGroup.enter()
					let songsRef = refGenerator.getCollectionRef(forDocumentRef: cultureRef, type: .cultureSongs)
					songsRef.getDocuments { (querySnapshot, error) in
						defer { dispatchGroup.leave() }
						if let querySnapshot = querySnapshot {
							var songs = [LessonCultureReferenceSongs]()
							for document in querySnapshot.documents {
								if let song = try? document.data(as: LessonCultureReferenceSongs.self) {
									songs.append(song)
								}
							}
							lesson.lessonCultureReferences?.songs = songs
						} else if let error = error {
							encounteredError = error
						}
					}
				} catch let error {
					encounteredError = error
				}
			} else if let error = error {
				encounteredError = error
			}
		}
		
		// Wait for all the asynchronous tasks to complete
		dispatchGroup.notify(queue: .main) {
			if let error = encounteredError {
				completion(nil, error)
			} else {
				completion(lesson, nil)
			}
		}
	}


}


