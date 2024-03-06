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
	
	func getCollectionRef(forDocumentRef docRef: DocumentReference, type: CollectionType) -> CollectionReference {
		switch type {
		case .goalsExamples:
			return docRef.collection("goalsExamples")
		case .grammarPages:
			return docRef.collection("LessonGrammarPages")
		case .practiceMultipleChoice:
			return docRef.collection("mulitpleChoice")
		case .practiceSentenceBuilding:
			return docRef.collection("sentenceBuilding")
		case .cultureSongs:
			return docRef.collection("songs")
		}
	}
}
