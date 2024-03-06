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
			try batch.setData(from: lesson.lessonTags, forDocument: lessonTagsRef)
			
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
				for page in grammar.LessonGrammarPages {
					let pageRef = refGenerator.getNewDocumentRef(forCollection: .grammarPages)
					try batch.setData(from: page, forDocument: pageRef)
				}
			}
			
			// Set lessonPractice
			if let lessonPractice = lesson.lessonPractice {
				let lessonPracticeRef = refGenerator.getDocumentRef(forType: .practice)
				batch.setData(lessonPractice.toFirebase(), forDocument: lessonPracticeRef)
				
				// Set lessonPractice multipleChoice
				for multipleChoice in lessonPractice.mulitpleChoice {
					let choiceRef = refGenerator.getNewDocumentRef(forCollection: .practiceMultipleChoice)
					try batch.setData(from: multipleChoice, forDocument: choiceRef)
				}
				
				// Set lessonPractice sentenceBuilding
				for sentenceBuilding in lessonPractice.sentenceBuilding {
					let sentenceRef = refGenerator.getNewDocumentRef(forCollection: .practiceSentenceBuilding)
					try batch.setData(from: sentenceBuilding, forDocument: sentenceRef)
				}
			}
			
			// Set lessonCultureReferences
			if let lessonCultureReferences = lesson.lessonCultureReferences {
				let lessonCultureReferencesRef = refGenerator.getDocumentRef(forType: .cultureReferences)
				batch.setData(lessonCultureReferences.toFirebase(), forDocument: lessonCultureReferencesRef)
				
				// Set lessonCultureReferences songs
				for song in lessonCultureReferences.songs {
					let songRef = refGenerator.getNewDocumentRef(forCollection: .cultureSongs)
					try batch.setData(from: song, forDocument: songRef)
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
}

// Helper class to generate Firestore document references based on document type or collection
class DocumentReferenceGenerator {
	private let lessonName: String
	private let language: String
	private var db: Firestore {
		Firestore.firestore()
	}
	
	init(lessonName: String, language: String) {
		self.lessonName = lessonName
		self.language = language
	}
	
	enum DocumentType {
		case info, tags, goal, vocabUsed, grammar, practice, cultureReferences
	}
	
	enum CollectionType {
		case goalsExamples, grammarPages, practiceMultipleChoice, practiceSentenceBuilding, cultureSongs
	}
	
	func getDocumentRef(forType type: DocumentType) -> DocumentReference {
		let lessonRef = db.collection("lessonsTEST").document(language).collection(lessonName)
		switch type {
		case .info:
			return lessonRef.document("info")
		case .tags:
			return lessonRef.document("tags")
		case .goal:
			return lessonRef.document("lessonGoal")
		case .vocabUsed:
			return lessonRef.document("vocabUsed")
		case .grammar:
			return lessonRef.document("grammar")
		case .practice:
			return lessonRef.document("practice")
		case .cultureReferences:
			return lessonRef.document("cultureReferences")
		}
	}
	
	func getNewDocumentRef(forCollection collection: CollectionType) -> DocumentReference {
		let lessonRef = db.collection("lessonsTEST").document(language).collection(lessonName)
		switch collection {
		case .goalsExamples:
			return lessonRef.document("lessonGoal").collection("goalsExamples").document()
		case .grammarPages:
			return lessonRef.document("grammar").collection("pages").document()
		case .practiceMultipleChoice:
			return lessonRef.document("practice").collection("multipleChoice").document()
		case .practiceSentenceBuilding:
			return lessonRef.document("practice").collection("sentenceBuild").document()
		case .cultureSongs:
			return lessonRef.document("cultureReferences").collection("songs").document()
		}
	}
}
