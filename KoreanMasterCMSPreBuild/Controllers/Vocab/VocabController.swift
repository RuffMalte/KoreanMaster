//
//  VocabController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import SwiftUI
import Observation
import Firebase
import FirebaseFirestore

@Observable
class VocabController: ObservableObject{
	
	var isLoadingVocabs: Bool = false
	
	func getVocab(with ids: [String]? = nil, language: String, completion: @escaping ([Vocab], Error?) -> Void) {
		isLoadingVocabs = true
		
		let generator = DocumentReferenceGenerator(language: language)
		let vocabCollection = generator.getVocabCollectionRef()
		
		// Fetch all vocabs
		vocabCollection.getDocuments { (querySnapshot, error) in
			self.isLoadingVocabs = false
			if let error = error {
				completion([], error)
			} else {
				var vocabs = querySnapshot?.documents.compactMap { document -> Vocab? in
					try? document.data(as: Vocab.self)
				} ?? []
				
				// If specific vocab IDs were provided, filter the fetched vocabs by these IDs
				if let ids = ids, !ids.isEmpty {
					vocabs = vocabs.filter { vocab in
						ids.contains(vocab.id)
					}
				}
				
				completion(vocabs, nil)
				self.isLoadingVocabs = false
			}
		}
	}

	
	func saveVocab(vocab: Vocab, language: String, completion: @escaping (Bool, Error?) -> Void) {
		let db = Firestore.firestore()
		let batch = db.batch()
		let refGenerator = DocumentReferenceGenerator(language: language)
		
		
		let vocabRef = refGenerator.getVocabDocRef(withId: vocab.id)
		
		do {
			try batch.setData(from: vocab, forDocument: vocabRef)
			
			batch.commit { error in
				if let error = error {
					completion(false, error)
				} else {
					completion(true, nil)
				}
			}
		} catch {
			print("Error writing vocab to Firestore: \(error)")
			completion(false, error)
		}
	}
	
	func deleteVocabs(with ids: [String], language: String, completion: @escaping (Bool, Error?) -> Void) {
		let db = Firestore.firestore()
		let batch = db.batch()
		let refGenerator = DocumentReferenceGenerator(language: language)
		
		for id in ids {
			let vocabRef = refGenerator.getVocabDocRef(withId: id)
			batch.deleteDocument(vocabRef)
		}
		
		batch.commit { error in
			if let error = error {
				completion(false, error)
			} else {
				completion(true, nil)
			}
		}
	}
}
