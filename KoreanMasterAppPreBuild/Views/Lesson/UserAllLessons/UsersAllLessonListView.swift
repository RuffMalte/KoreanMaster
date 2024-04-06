//
//  UsersAllLessonListView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 28.03.24.
//

import SwiftUI
import SwiftData

struct UsersAllLessonListView: View {
	
	
	@State var currentLessons: [Lesson] = []
	
	@Query var localVocabs: [UserLocalVocab]
	@Environment(\.modelContext) var modelContext

	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var courseCon: CoursesController
	
		
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .red
	@State private var isLoadingLessons = false

    var body: some View {
		VStack {
			if let currentFirestoreUser = loginCon.currentFirestoreUser {
				VStack {
					if isLoadingLessons {
						ProgressView()
					} else {
						VStack {
							UserAllLessonStatsView(currentUser: currentFirestoreUser)
							
							ExploreAllLocalizedLessonsView(
								lessons: currentLessons,
								currentLanguage: currentFirestoreUser.languageSelected,
								completedLessonIDs: currentFirestoreUser.compeltedLessonsIDS
							) { lesson in
								
								//Streak
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
								
								//XP
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
								
								//Completed Lesson
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
								
								UserComponentsController().getLocaluservocabFromVocabIDs(
									for: lesson.newLessonVocabUsed?.vocabIDs ?? [],
									with: currentFirestoreUser.languageSelected, 
									currentLocalVocab: localVocabs
								) { userLocalVocab, error in
									if error == nil {
										for localVocab in userLocalVocab {
											print(localVocab.id)
											modelContext.insert(localVocab)
										}
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
					}
				}
				.onAppear {
					if courseCon.currentLessons.isEmpty {
						isLoadingLessons = true
						courseCon.getAllLessons(language: currentFirestoreUser.languageSelected) { lessons, error in
							if let error = error {
								print("Error getting lessons: \(error)")
							} else {
								self.currentLessons = lessons
								courseCon.currentLessons = lessons
								isLoadingLessons = false
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
