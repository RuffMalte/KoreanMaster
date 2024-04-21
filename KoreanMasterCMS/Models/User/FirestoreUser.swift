//
//  FirestoreUser.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import Foundation

class FirestoreUser: Identifiable, Encodable, Decodable {
	var id: String
	var email: String
	var displayName: String
	var isAdmin: Bool
	var isAdminLesson: Bool
	var languageSelected: String
		
	var totalXP: Int
	
	
	
	var daysStreak: Int
	var maxStreakDays: Int = 0
	var streaks: [StreakDay] =  []
	
	
	
	var createdAt: Date
	var totalLiked: Int
	var totalComments: Int
	
	
	var compeltedLessonsIDS: [String] = []
	
	init(
		id: String,
		email: String,
		displayName: String,
		isAdmin: Bool = false,
		isAdminLesson: Bool = false,
		languageSelected: String = "English",
		totalXP: Int = 0,
		daysStreak: Int = 0,
		createAT: Date = Date(),
		totalLiked: Int = 0,
		totalComments: Int = 0
	) {
		self.id = id
		self.email = email
		self.displayName = displayName
		self.isAdmin = isAdmin
		self.isAdminLesson = isAdminLesson
		self.languageSelected = languageSelected
		self.totalXP = totalXP
		self.daysStreak = daysStreak
		self.createdAt = createAT
		self.totalLiked = totalLiked
		self.totalComments = totalComments
	}
	
	
	func copy() -> FirestoreUser {
		let copy = FirestoreUser(
			id: id,
			email: email,
			displayName: displayName,
			isAdmin: isAdmin,
			isAdminLesson: isAdminLesson,
			languageSelected: languageSelected,
			totalXP: totalXP,
			daysStreak: daysStreak,
			createAT: createdAt,
			totalLiked: totalLiked,
			totalComments: totalComments
		)
		copy.compeltedLessonsIDS = compeltedLessonsIDS
		copy.streaks = streaks
		copy.maxStreakDays = maxStreakDays
		return copy
	}
}

struct StreakDay: Identifiable, Codable {
	var id: String = UUID().uuidString
	var date: Date
	var xpGained: Int
}
