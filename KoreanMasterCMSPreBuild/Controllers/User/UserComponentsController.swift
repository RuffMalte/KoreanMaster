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
		
	func addStreakItem(for userID: String, preSelectedUser: FirestoreUser?, providedStreakDay: StreakDay? = nil, completion: @escaping (FirestoreUser?, Error?) -> Void) {
		let db = Firestore.firestore()
		
		func updateUserStreaks(_ user: FirestoreUser) {
			user.streaks.sort { $0.date < $1.date }
			
			let cutoffDate = Calendar.current.date(byAdding: .day, value: -14, to: Date())!
			user.streaks = user.streaks.filter { $0.date >= cutoffDate }
			
			var isNewStreakAdded = false
			
			let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
			let hasStreakForYesterday = user.streaks.contains { Calendar.current.isDate($0.date, inSameDayAs: yesterday) }
			
			if let streakDay = providedStreakDay {
				if !user.streaks.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: streakDay.date) }) {
					user.streaks.append(streakDay)
					isNewStreakAdded = Calendar.current.isDateInToday(streakDay.date)
				}
				user.totalXP = user.totalXP + streakDay.xpGained
			} else if !user.streaks.contains(where: { Calendar.current.isDateInToday($0.date) }) {
				user.streaks.append(StreakDay(date: Date(), xpGained: 0))
				isNewStreakAdded = true
				user.totalXP = user.totalXP + 0
			}
			
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




	
}
