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
			
			var isNewStreakAdded = false
			
			let targetDate = providedStreakDay?.date ?? Date()
			if let index = user.streaks.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: targetDate) }) {
				// Streak day exists, update its xpGained
				user.streaks[index].xpGained += xpToGain
				isNewStreakAdded = Calendar.current.isDateInToday(user.streaks[index].date)
			} else {
				// No streak for today, add new one
				let newStreakDay = StreakDay(date: targetDate, xpGained: xpToGain)
				user.streaks.append(newStreakDay)
				isNewStreakAdded = true
			}
			
			user.totalXP += xpToGain
			
			if isNewStreakAdded || user.streaks.isEmpty {
				user.daysStreak += 1
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



	
}
