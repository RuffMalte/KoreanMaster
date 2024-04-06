//
//  UserComponentsController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI
import Firebase
import Observation

@Observable
class UserComponentsController: Observable {
		
	func addStreakItem(for userID: String, preSelectedUser: FirestoreUser?, xpToGain: Int, providedStreakDay: StreakDay? = nil, completion: @escaping (FirestoreUser?, Error?) -> Void) {
		let db = Firestore.firestore()
		
		func updateUserStreaks(_ user: FirestoreUser) {
			user.streaks.sort { $0.date < $1.date }
			
			let cutoffDate = Calendar.current.date(byAdding: .day, value: -14, to: Date())!
			user.streaks = user.streaks.filter { $0.date >= cutoffDate }
			
			let today = Date()
			let targetDate = providedStreakDay?.date ?? today
			let todayStreakIndex = user.streaks.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: targetDate) })
			
			var isNewStreakAdded = false
			
			if let index = todayStreakIndex {
				if Calendar.current.isDateInToday(user.streaks[index].date) {
					user.streaks[index].xpGained += xpToGain
				}
			} else {
				if let lastStreakDate = user.streaks.last?.date, Calendar.current.isDate(lastStreakDate, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: today)!) == false {
					user.daysStreak = 1
				} else {
					user.daysStreak += 1
				}
				let newStreakDay = StreakDay(date: targetDate, xpGained: xpToGain)
				user.streaks.append(newStreakDay)
				isNewStreakAdded = true
			}
			
			user.totalXP += xpToGain
			
			if isNewStreakAdded {
				if user.daysStreak > user.maxStreakDays {
					user.maxStreakDays = user.daysStreak
				}
			}
			
			let userRef = db.collection("users").document(user.id)
			do {
				try userRef.setData(from: user) { error in
					if let error = error {
						completion(nil, error)
					} else {
						completion(user, nil)
					}
				}
			} catch let error {
				completion(nil, error)
			}
		}
		
		if let preselected = preSelectedUser {
			updateUserStreaks(preselected)
		} else {
			let userRef = db.collection("users").document(userID)
			userRef.getDocument { (document, error) in
				if let document = document, document.exists, let user = try? document.data(as: FirestoreUser.self) {
					updateUserStreaks(user)
				} else {
					completion(nil, error ?? NSError(domain: "addStreakItem", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user for updating streaks."]))
				}
			}
		}
	}



	
	
	func addXP(for userID: String, xp: Int, completion: @escaping (FirestoreUser?, Error?) -> Void) {
		let db = Firestore.firestore()
		
		let userRef = db.collection("users").document(userID)
		userRef.getDocument { (document, error) in
			if let document = document, document.exists, let user = try? document.data(as: FirestoreUser.self) {
				user.totalXP += xp
				do {
					try userRef.setData(from: user) { error in
						if let error = error {
							completion(nil, error)
						} else {
							completion(user, nil)
						}
					}
				} catch let error {
					completion(nil, error)
				}
			} else {
				completion(nil, error ?? NSError(domain: "addXP", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user for updating XP."]))
			}
		}
	}


	func addCompletedLesson(for userID: String, lessonID: String, completion: @escaping (FirestoreUser?, Error?) -> Void) {
		let db = Firestore.firestore()
		
		let userRef = db.collection("users").document(userID)
		userRef.getDocument { (document, error) in
			if let document = document, document.exists, let user = try? document.data(as: FirestoreUser.self) {
				if user.compeltedLessonsIDS.contains(lessonID) {
					completion(user, nil)
				} else {
					user.compeltedLessonsIDS.append(lessonID)
				}
				do {
					try userRef.setData(from: user) { error in
						if let error = error {
							completion(nil, error)
						} else {
							completion(user, nil)
						}
					}
				} catch let error {
					completion(nil, error)
				}
			} else {
				completion(nil, error ?? NSError(domain: "addCompletedLesson", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user for adding completed lesson."]))
			}
		}
	}
	
	
	func getLocaluservocabFromVocabIDs(
		for vocabIDs: [String],
		with language: String,
		currentLocalVocab: [UserLocalVocab],
		completion: @escaping ([UserLocalVocab], Error?) -> Void
	) {
		let vocabCon: VocabController = VocabController()
		
		vocabCon.getVocab(with: vocabIDs, language: language) { fetchedVocab, error in
			if error == nil {
				var vocab: [Vocab] = []
				vocab = fetchedVocab.filter { vocab in
					!currentLocalVocab.contains(where: { $0.id == vocab.id })
				}
				
				let newUserLocalVocab = vocab.map { UserLocalVocab(from: $0) }
				
				completion(newUserLocalVocab, nil)
			}
		}
	}
	
}
