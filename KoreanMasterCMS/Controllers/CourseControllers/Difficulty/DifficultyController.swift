//
//  DifficultyController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI
import Observation
import Firebase
import FirebaseFirestore

@Observable
class DifficultyController: ObservableObject {
	
	
	var isLoadingDifficulty: Bool = false
	
	func getDifficulties(with ids: [String]? = nil, language: String, completion: @escaping ([LessonDiffuculty], Error?) -> Void) {
		isLoadingDifficulty = true
		
		let generator = DocumentReferenceGenerator(language: language)
		let difficultyCollection = generator.getDifficultyCollectionPath()
		
		
		difficultyCollection.getDocuments { (querySnapshot, error) in
			self.isLoadingDifficulty = false
			if let error = error {
				completion([], error)
			} else {
				var difficulties = querySnapshot?.documents.compactMap { document -> LessonDiffuculty? in
					try? document.data(as: LessonDiffuculty.self)
				} ?? []
				
				if let ids = ids, !ids.isEmpty {
					difficulties = difficulties.filter { vocab in
						ids.contains(vocab.id)
					}
				}
				
				completion(difficulties, nil)
				self.isLoadingDifficulty = false
			}
		}
	}
	
	
	func saveDiffuculty(difficulty: LessonDiffuculty, language: String, completion: @escaping (Bool, Error?) -> Void) {
		let db = Firestore.firestore()
		let batch = db.batch()
		let refGenerator = DocumentReferenceGenerator(language: language)
		
		
		let difficultyRef = refGenerator.getDifficultyDocRef(withId: difficulty.id)
		
		do {
			try batch.setData(from: difficulty, forDocument: difficultyRef)
			
			batch.commit { error in
				if let error = error {
					completion(false, error)
				} else {
					completion(true, nil)
				}
			}
		} catch {
			print("Error writing difficulty to Firestore: \(error)")
			completion(false, error)
		}
	}
	
	
	
	func deleteDifficulties(with ids: [String], language: String, completion: @escaping (Bool, Error?) -> Void) {
		let db = Firestore.firestore()
		let batch = db.batch()
		let refGenerator = DocumentReferenceGenerator(language: language)
		
		for id in ids {
			let difficultyRef = refGenerator.getDifficultyDocRef(withId: id)
			batch.deleteDocument(difficultyRef)
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
