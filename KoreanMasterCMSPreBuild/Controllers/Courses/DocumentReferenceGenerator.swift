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
	private let lessonName: String?
	private let language: String
	private var db: Firestore {
		Firestore.firestore()
	}
	
	init(lessonName: String? = nil, language: String) {
		self.lessonName = lessonName
		self.language = language
	}
	
	private var mainCollectionPath: String {
		"lessonsTEST/\(language)/lessons"  // Adjusted path
	}
	
	enum DocumentType: String {
		case info, tags, goal, vocabUsed, grammar, practice, cultureReferences
	}
	
	enum CollectionType: String {
		case goalsExamples, grammarPages, practiceMultipleChoice, practiceSentenceBuilding, cultureSongs
	}
	
	// Returns a reference to the collection of lesson documents for a specific language
	func getLessonsCollectionRef() -> CollectionReference {
		return db.collection(mainCollectionPath)
	}
	
	// Returns a reference to a specific lesson document
	func getDocumentRef(forType type: DocumentType) -> DocumentReference {
		guard let lessonName = lessonName else {
			fatalError("Document reference requested without specifying lesson name.")
		}
		let lessonRef = getLessonsCollectionRef().document(lessonName)
		switch type {
		case .info:
			return lessonRef.collection("details").document("info")
		case .tags:
			return lessonRef.collection("details").document("tags")
		case .goal:
			return lessonRef.collection("details").document("lessonGoal")
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
	
	// Adjustments are not needed here as this method is fine for creating new subdocuments within lessons
	func getNewDocumentRef(forCollection collection: CollectionType) -> DocumentReference {
		guard let lessonName = lessonName else {
			fatalError("New document reference requested without specifying lesson name.")
		}
		let lessonRef = getLessonsCollectionRef().document(lessonName)
		switch collection {
		case .goalsExamples:
			return lessonRef.collection("goalsExamples").document()
		case .grammarPages:
			return lessonRef.collection("LessonGrammarPages").document()
		case .practiceMultipleChoice:
			return lessonRef.collection("multipleChoice").document()
		case .practiceSentenceBuilding:
			return lessonRef.collection("sentenceBuild").document()
		case .cultureSongs:
			return lessonRef.collection("songs").document()
		}
	}
	
	// Method for getting subcollection references from a specific document
	func getCollectionRef(forDetail detailType: DocumentType, subCollection: CollectionType) -> CollectionReference {
		guard let lessonName = lessonName else {
			fatalError("Collection reference requested without specifying lesson name.")
		}
		
		// Path to the specific detail document (like 'grammar', 'practice', etc. under 'details' collection)
		let detailDocumentRef = db.collection(self.mainCollectionPath)
			.document(lessonName)
			.collection("details")
			.document(detailType.rawValue)
		
		
		switch subCollection {
		case .goalsExamples:
			return detailDocumentRef.collection("goalsExamples")  // Adjust if necessary
		case .grammarPages:
			return detailDocumentRef.collection("grammarPages")  // Adjust if necessary
		case .practiceMultipleChoice:
			return detailDocumentRef.collection("multipleChoice")  // Adjust if necessary
		case .practiceSentenceBuilding:
			return detailDocumentRef.collection("sentenceBuild")  // Adjust if necessary
		case .cultureSongs:
			return detailDocumentRef.collection("songs")  // Adjust if necessary
		}
	}
}

