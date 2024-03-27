//
//  MainTabView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct MainTabView: View {
	
	@State var selectedTab: Int = 0
	
	var lesson = Lesson.detailExample
	
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
#if os(iOS)
			
		TabView(selection: $selectedTab) {
			InSessionLessonMainView(lesson: lesson, currentLanguage: "English") {
				if let user = loginCon.currentFirestoreUser {
					print("Hello")
					UserComponentsController().addStreakItem(
						for: user.id,
						preSelectedUser: user,
						providedStreakDay: StreakDay(
							date: Date(),
							xpGained: lesson.lessonInfo.xpToGain)
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
				}
			}
			.tabItem {
				Label("Lesson", systemImage: "book.fill")
					.tag(0)
			}
			
			Text("Vocab")
				.tabItem {
					Label("Vocab", systemImage: "text.book.closed.fill")
						.tag(1)
				}
			
			Text("Use the Camera to find and automatically translate objects")
				.tabItem {
					Label("Scan", systemImage: "square.dashed")
						.tag(2)
				}
			
			UserMainProfileView()
				.tabItem {
					Label("Profile", systemImage: "person.fill")
						.tag(3)
				}
			
			
			
		}
			
			
#elseif os(macOS)
		
		
#endif
    }
}

#Preview {
    MainTabView()
		.withEnvironmentObjects()
}
