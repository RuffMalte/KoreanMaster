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
	@EnvironmentObject var alertModal: AlertManager

		
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .red
	@State private var isLoadingLessons = false

	
	@State private var afterLesson: AfterLessonModel?
	
    var body: some View {
		VStack {
			if let currentFirestoreUser = loginCon.currentFirestoreUser {
				VStack {
					if isLoadingLessons {
						ProgressView()
					} else {
						VStack {
							UserAllLessonStatsView(currentUser: currentFirestoreUser)
							
							Divider()
							
							ExploreAllLocalizedLessonsView(
								lessons: currentLessons,
								currentLanguage: currentFirestoreUser.languageSelected,
								completedLessonIDs: currentFirestoreUser.compeltedLessonsIDS
							) { lesson in
								handleLessonActions(lesson: lesson, user: currentFirestoreUser, loginController: loginCon) { hasNewStreakItem in
									
									let newAfterLesson = AfterLessonModel(lesson: lesson, user: currentFirestoreUser, hasNewStreakItem: hasNewStreakItem)
									
									withAnimation {
										self.afterLesson = newAfterLesson
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
				.withAlertModal(isPresented: $alertModal.isModalPresented)
				.onAppear {
					if courseCon.currentLessons.isEmpty {
						isLoadingLessons = true
						courseCon.getAllLessons(language: currentFirestoreUser.languageSelected) { lessons, error in
							if let error = error {
								alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
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
				.overlay {
					if let afterLesson = afterLesson {
						HStack {
							Spacer()
							VStack {
								Spacer()
								AfterLessonMainView(afterLesson: afterLesson) {
									withAnimation {
										self.afterLesson = nil
									}
								}
								Spacer()
							}
							Spacer()
						}
						.background(.ultraThinMaterial)
						.ignoresSafeArea()
						.presentationCompactAdaptation(.fullScreenCover)
					}
				}
			}
		}
		
	}
	
	func handleLessonActions(lesson: Lesson, user: FirestoreUser, loginController: LoginController, completion: @escaping (Bool) -> Void) {
		let userComponentsController = UserComponentsController()
		
		var hasNewStreakItem: Bool = false
		
		let oldUser = user.copy()
		
		userComponentsController.addStreakItem(for: user.id, preSelectedUser: user, xpToGain: lesson.lessonInfo.xpToGain) { newUser, error in
			if let error = error {
				print("Error adding streak item: \(error)")
				return
			}
			
			// If the user has a new streak item
			if oldUser.streaks.last?.date != newUser?.streaks.last?.date {
				hasNewStreakItem = true
			}
			if let newUser = newUser {
				loginController.currentFirestoreUser = newUser
				
				userComponentsController.addXP(for: user.id, xp: lesson.lessonInfo.xpToGain) { updatedUser, error in
					if let error = error {
						print("Error adding XP: \(error)")
						return
					}
					
					if let updatedUser = updatedUser {
						loginController.currentFirestoreUser = updatedUser
						
						userComponentsController.addCompletedLesson(for: user.id, lessonID: lesson.id) { finalUser, error in
							if error != nil {
								return
							}
							
							if let finalUser = finalUser {
								loginController.currentFirestoreUser = finalUser
								
								let vocabIDs = lesson.newLessonVocabUsed?.vocabIDs ?? []
								userComponentsController.getLocaluservocabFromVocabIDs(for: vocabIDs, with: user.languageSelected, currentLocalVocab: localVocabs) { userLocalVocab, error in
									if let error = error {
										print("Error fetching local vocabulary: \(error)")
										return
									}
									
									for localVocab in userLocalVocab {
										modelContext.insert(localVocab)
									}
									
									
									
									completion(hasNewStreakItem)
									
								}
							} else {
								print("Error: Final user is nil after adding completed lesson")
							}
						}
					} else {
						print("Error: Updated user is nil after adding XP")
					}
				}
			} else {
				print("Error: New user is nil after adding streak")
			}
		}
	}

}

#Preview {
    UsersAllLessonListView()
		.withEnvironmentObjects()
}
