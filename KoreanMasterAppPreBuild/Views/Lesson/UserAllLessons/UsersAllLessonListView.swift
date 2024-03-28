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
					
					ExploreAllLocalizedLessonsView(lessons: currentLessons, currentLanguage: currentFirestoreUser.languageSelected, completedLessonIDs: currentFirestoreUser.compeltedLessonsIDS) { lesson in
						
						UserComponentsController().addStreakItem(
							for: currentFirestoreUser.id, 
							preSelectedUser: currentFirestoreUser,
							xpToGain: lesson.lessonInfo.xpToGain
						)
						{ newUser, error in
							if let error = error {
								print("Error adding streak item: \(error)")
							}
							if let newUser = newUser {
								loginCon.currentFirestoreUser = newUser
								print(newUser.daysStreak.description)
							}
						}
						
						UserComponentsController().addXP(
							for: currentFirestoreUser.id,
							xp: lesson.lessonInfo.xpToGain
						) { user, error in
							if let error = error {
								print("Error adding XP: \(error)")
							} else if let user = user {
								loginCon.currentFirestoreUser = user
							} else {
								print("Error adding XP: User is nil")
							}
						}
						
						UserComponentsController().addCompletedLesson(
							for: currentFirestoreUser.id,
							lessonID: lesson.id
						) { user, error in
							if let error = error {
								print("Error adding completed lesson: \(error)")
							} else if let user = user {
								loginCon.currentFirestoreUser = user
							} else {
								print("Error adding completed lesson: User is nil")
							}
						}
					}
					
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
}

#Preview {
    UsersAllLessonListView()
		.withEnvironmentObjects()
}
