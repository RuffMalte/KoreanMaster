//
//  UsersAllLessonListView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 28.03.24.
//

import SwiftUI

struct UsersAllLessonListView: View {
	
	
	@State var currentLessons: [Lesson] = []
	
	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var courseCon: CoursesController
		
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .red

    var body: some View {
		VStack {
			if let currentFirestoreUser = loginCon.currentFirestoreUser {
				VStack {
					UserAllLessonStatsView(currentUser: currentFirestoreUser)
					
					ExploreAllLocalizedLessonsView(lessons: currentLessons, currentLanguage: currentFirestoreUser.languageSelected)
					
				}
				
				.background {
					VStack {
						Rectangle()
							.foregroundStyle(.clear)
							.fadeToClear(startColor: selectedTintColor.toColor.opacity(0.75), endColor: selectedTintColor.getOpposite.toColor.opacity(0.75), height: 180)
							.ignoresSafeArea()
						
						Spacer()
					}
				}
				.onAppear {
					if courseCon.currentLessons.isEmpty {
						courseCon.getAllLessons(language: currentFirestoreUser.languageSelected) { lessons, error in
							if let error = error {
								print("Error getting lessons: \(error)")
							} else {
								self.currentLessons = lessons
								courseCon.currentLessons = lessons
							}
						}
					} else {
						currentLessons = courseCon.currentLessons
					}
				}
			}
		}
		
	}
		
//		InSessionLessonMainView(lesson: lesson, currentLanguage: "English") {
//			if let user = loginCon.currentFirestoreUser {
//				print("Hello")
//				UserComponentsController().addStreakItem(
//					for: user.id,
//					preSelectedUser: user,
//					providedStreakDay: StreakDay(
//						date: Date(),
//						xpGained: lesson.lessonInfo.xpToGain)
//				)
//				{ newUser, error in
//					if let error = error {
//						print("Error adding streak item: \(error)")
//					}
//					if let newUser = newUser {
//						loginCon.currentFirestoreUser = newUser
//						print(newUser.daysStreak.description)
//					}
//				}
//			}
//		}
		
		
		
    
}

#Preview {
    UsersAllLessonListView()
		.withEnvironmentObjects()
}
