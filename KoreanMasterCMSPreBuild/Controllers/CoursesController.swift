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
	
	private let infoRefDocumentName: String = "info"
	private let commentsRefDocumentName: String = "userComments"
	private let likedByRefDocumentName: String = "likedBy"
	private let tagsRefDocumentName: String = "tags"
	private let goalRefDocumentName: String = "lessonGoal"
	private let goalsExampleRefDocumentName: String = "goalsExamples"
	private let vocabUsedRefDocumentName: String = "vocabUsed"
	private let grammerRefDocumentName: String = "grammer"
	private let grammerPagesRefDocumentName: String = "pages"
	private let praticeRefDocumentName: String = "pratice"
	private let praticeMultipleChoiceRefDocumentName: String = "multipleChoice"
	private let praticeSentenceRefDocumentName: String = "sentenceBuild"
	private let cultureRefDocumentName: String = "cultureReferences"
	private let cultureSongsRefDocumentName: String = "songs"
	
	func addNewLesson(lesson: Lesson, language: String, completion: @escaping (Bool) -> Void) {
		let db = Firestore.firestore()
		
		
		let lessonRef = db.collection("lessonsTEST").document(language).collection(lesson.lessonInfo.lessonName)
		
		
		do {
			//set info
			let lessonInfoRef = lessonRef.document(self.infoRefDocumentName)
			lessonInfoRef.setData(lesson.lessonInfo.toFirebase())
			
			//set tags
			let lessonTagsRef = lessonRef.document(self.tagsRefDocumentName)
			try lessonTagsRef.setData(from: lesson.lessonTags)
			
			
			//set goals
			let lessonGoalRef = lessonRef.document(self.goalRefDocumentName)
			lessonGoalRef.setData(lesson.lessonGoal?.toFirebase() ?? [:])
			
				//set lessonGoals Example
				let lessonGoalExampleRef = lessonGoalRef.collection(self.goalsExampleRefDocumentName)
				for example in lesson.lessonGoal?.lessonGoalExamples ?? [] {
					try lessonGoalExampleRef.addDocument(from: example)
				}
			
			//set newLessonVocabUsed
			let newLessonVocabUsedRef = lessonRef.document(self.vocabUsedRefDocumentName)
			try newLessonVocabUsedRef.setData(from: lesson.newLessonVocabUsed)
			
			
			//set lessonGrammer
			let lessonGrammerRef = lessonRef.document(self.grammerRefDocumentName)
			lessonGrammerRef.setData(lesson.lessonGrammer?.toFirebase() ?? [:])
			
				//set lessonGrammer Pages
				let lessonGrammerPagesRef = lessonGrammerRef.collection(self.grammerPagesRefDocumentName)
				for page in lesson.lessonGrammer?.lessonGrammerPages ?? [] {
					try lessonGrammerPagesRef.addDocument(from: page)
				}
			
			
			//set lessonPratice
			let lessonPraticeRef = lessonRef.document(self.praticeRefDocumentName)
			lessonPraticeRef.setData(lesson.lessonPratice?.toFirebase() ?? [:])
			
				//set lessonPratice multipleChoice
				let lessonPraticeMultipleChoiceRef = lessonPraticeRef.collection(self.praticeMultipleChoiceRefDocumentName)
				for multipleChoice in lesson.lessonPratice?.mulitpleChoice ?? [] {
					try lessonPraticeMultipleChoiceRef.addDocument(from: multipleChoice)
				}
			
				//set lessonPractie sentenceBuilding
				let lessonPraticeSentenceBuildingRef = lessonPraticeRef.collection(self.praticeSentenceRefDocumentName)
				for sentenceBuilding in lesson.lessonPratice?.sentenceBuilding ?? [] {
					try lessonPraticeSentenceBuildingRef.addDocument(from: sentenceBuilding)
				}
			
			
			//set lessonCultureReferences
			let lessonCultureReferencesRef = lessonRef.document(self.cultureRefDocumentName)
			lessonCultureReferencesRef.setData(lesson.lessonCultureReferences?.toFirebase() ?? [:])
			
				//set lessonCultureReferences songs
				let lessonCultureReferencesItemsRef = lessonCultureReferencesRef.collection(self.cultureSongsRefDocumentName)
				for song in lesson.lessonCultureReferences?.songs ?? [] {
					try lessonCultureReferencesItemsRef.addDocument(from: song)
				}
			
			
			
			completion(true)
			
		} catch {
			print("Error writing lesson to Firestore: \(error)")
			completion(false)
		}
		
		
		
	}
	
	
	
}
