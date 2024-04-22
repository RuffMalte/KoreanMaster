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
	@EnvironmentObject var alertModal: AlertManager

    var body: some View {
#if os(iOS)
			
		TabView(selection: $selectedTab) {
			UsersAllLessonListView()
			.tabItem {
				Label("Lesson", systemImage: "book.fill")
					.tag(0)
			}
			
			AllLocalVocabView()
				.tabItem {
					Label("Vocab", systemImage: "text.book.closed.fill")
						.tag(1)
				}
			
			UserMainProfileView()
				.tabItem {
					Label("Profile", systemImage: "person.fill")
						.tag(2)
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
