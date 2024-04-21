//
//  WithEnviromentObjects.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct WithEnvironmentObjects: ViewModifier {
	
	
	init(isUserAdmin: Bool? = nil) {
		let newLoginCon = LoginController()
		
		let newFirestoreUser = FirestoreUser(id: UUID().uuidString, email: "email@email.cpm", displayName: "Malte", isAdmin: isUserAdmin ?? false, isAdminLesson: isUserAdmin ?? false, languageSelected: "English")
		
		
		newFirestoreUser.streaks = [
			StreakDay(date: Date().addingTimeInterval(-86400), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 2), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 3), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 4), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 5), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 6), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 7), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 8), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 9), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 10), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 11), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 12), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 13), xpGained: Int.random(in: 0...200)),
			StreakDay(date: Date().addingTimeInterval(-86400 * 14), xpGained: Int.random(in: 0...200)),
		]
		
		
		newLoginCon.currentFirestoreUser = newFirestoreUser

		
		self.loginController = newLoginCon
		
		
		let newCoursesCon = CoursesController()
		
		newCoursesCon.currentLessons = [
			Lesson.detailExample,
			Lesson.detailExample,
			Lesson.detailExample,
			Lesson.detailExample,
			Lesson.detailExample,
			Lesson.detailExample,
			Lesson.detailExample,
			Lesson.detailExample
		]
		
		self.coursesController = newCoursesCon
	}
	
	var loginController = LoginController()
	var coursesController = CoursesController()
	
	func body(content: Content) -> some View {
		content
			.environment(loginController)
			.environment(coursesController)
	}
}

// Extend View to include the custom modifier for easier use
extension View {
	func withEnvironmentObjects(isUserAdmin: Bool? = nil) -> some View {
		self.modifier(WithEnvironmentObjects())
	}
}
