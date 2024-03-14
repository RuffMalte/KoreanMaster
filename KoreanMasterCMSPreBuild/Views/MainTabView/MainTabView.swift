//
//  MainTabView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct MainTabView: View {
	
	
	@State private var isShowingProfile: Bool = false
	
	
    var body: some View {
		#if os(iOS)
		
		TabView {
			
			Text("Home")
				.tabItem {
					Image(systemName: "house")
					Text("Home")
				}
			
		}
		
		
		#elseif os(macOS)
		
		NavigationSplitView {
			List {
				NavigationLink {
					UserListView()
				} label: {
					Label("Users", systemImage: "person.3.fill")
				}
				
				NavigationLink {
					LanguagesListView()
				} label: {
					Label("Languages", systemImage: "globe")
				}
				
				NavigationLink {
					AllLessonsListView()
				} label: {
					Label("Courses", systemImage: "book.fill")
				}

				NavigationLink {
					AllVocabListView()
				} label: {
					Label("Vocabularies", systemImage: "text.book.closed.fill")
				}

				NavigationLink {
					AllWelcomeMessages()
				} label: {
					Label("Welcome Messages", systemImage: "message.fill")
				}

			}
			
		} detail: {
			ContentUnavailableView("Select something to edit",
			   systemImage: "graduationcap.fill",
			   description: Text("Select a course, lesson, or vocabulary to edit it.")
			)
		}
		.toolbar(content: {
			ToolbarItem(placement: .automatic) {
				Button(action: {
					isShowingProfile.toggle()
				}, label: {
					Label("Profile", systemImage: "person.crop.circle.fill")
				})
			}
		})
		.sheet(isPresented: $isShowingProfile) {
			NavigationStack {
				ProfileView()
			}
			.frame(width: 400, height: 200, alignment: .center)
		}
		
		
		#endif
    }
}

#Preview {
    MainTabView()
}
