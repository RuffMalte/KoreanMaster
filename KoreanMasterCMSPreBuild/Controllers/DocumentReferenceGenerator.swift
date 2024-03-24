//
//  DocumentReferenceGenerator.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 06.03.24.
//

import SwiftUI
import Observation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


/// Helper class to generate Firestore document references based on document type or collection
class DocumentReferenceGenerator {
	let lessonID: String?
	let language: String
	private var db: Firestore {
		Firestore.firestore()
	}
	
	init(lessonID: String? = nil, language: String) {
		self.lessonID = lessonID
		self.language = language
	}
	
	var mainPath: String {
		"lessonData/\(language)"
	}
	
	var mainLessonPath: String {
		"\(self.mainPath)/lessons"
	}
	
	enum DocumentType: String, CaseIterable {
		case info, tags, goal, vocabUsed, grammar, practice, cultureReferences
		
	}
	enum InSessionLessonType: String, CaseIterable {
		case info, goal, vocabUsed, grammar, practice, cultureReferences
	}
	
	enum CollectionType: String, CaseIterable {
		case goalsExamples, grammarPages, practiceMultipleChoice, practiceSentenceBuilding, cultureSongs
	}
	
	enum PraticeType: String, CaseIterable {
		case multipleChoice, sentenceBuilding
	}
	
	// Returns a reference to the collection of lesson documents for a specific language
	func getLessonsCollectionRef() -> CollectionReference {
		return db.collection(mainLessonPath)
	}
	
	// Returns a reference to a specific lesson document
	func getDocumentRef(forType type: DocumentType) -> DocumentReference {
		guard let lessonName = lessonID else {
			fatalError("Document reference requested without specifying lesson name.")
		}
		let lessonRef = getLessonsCollectionRef().document(lessonName)
		switch type {
		case .info:
			return lessonRef.collection("details").document("info")
		case .tags:
			return lessonRef.collection("details").document("tags")
		case .goal:
			return lessonRef.collection("details").document("goal")
		case .vocabUsed:
			return lessonRef.collection("details").document("vocabUsed")
		case .grammar:
			return lessonRef.collection("details").document("grammar")
		case .practice:
			return lessonRef.collection("details").document("practice")
		case .cultureReferences:
			return lessonRef.collection("details").document("cultureReferences")
		}
	}
	
	// Method for getting subcollection references from a specific document
	func getCollectionRef(forDetail detailType: DocumentType, subCollection: CollectionType) -> CollectionReference {
		guard let lessonName = lessonID else {
			fatalError("Collection reference requested without specifying lesson name.")
		}
		
		// Path to the specific detail document (like 'grammar', 'practice', etc. under 'details' collection)
		let detailDocumentRef = db.collection(self.mainLessonPath)
			.document(lessonName)
			.collection("details")
			.document(detailType.rawValue)
		
		
		switch subCollection {
		case .goalsExamples:
			return detailDocumentRef.collection("goalsExamples")
		case .grammarPages:
			return detailDocumentRef.collection("grammarPages")
		case .practiceMultipleChoice:
			return detailDocumentRef.collection("multipleChoice")
		case .practiceSentenceBuilding:
			return detailDocumentRef.collection("sentenceBuild")
		case .cultureSongs:
			return detailDocumentRef.collection("songs")
		}
	}
	
	
	var welcomeMessagePath: String {
		"\(self.mainPath)/welcomeMessage"
	}
	
	func getDocWelcomeMessageRef(withId id: String) -> DocumentReference {
		return db.collection(self.welcomeMessagePath).document(id)
		
	}

	func getWelcomeMessagesRef() -> CollectionReference {
		return db.collection(self.welcomeMessagePath)
	}
	
	
	var vocabPath: String {
		"\(self.mainPath)/vocab"
	}
	
	func getVocabCollectionRef() -> CollectionReference {
		return db.collection(self.vocabPath)
	}
	
	func getVocabDocRef(withId id: String) -> DocumentReference {
		return db.collection(self.vocabPath).document(id)
	}
	
	
	var difficultyPath: String {
		"\(self.mainPath)/difficulty"
	}
	
	func getDifficultyCollectionPath() -> CollectionReference {
		return db.collection(self.difficultyPath)
	}
	
	func getDifficultyDocRef(withId id: String) -> DocumentReference {
		return db.collection(self.difficultyPath).document(id)
	}
	
}

