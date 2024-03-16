//
//  AllLessonsListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 06.03.24.
//

import SwiftUI

struct AllLessonsListView: View {
	
	
	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var courseCon: CoursesController

	
	@State var allLessonsLocalized: AllLessonsLocalized = AllLessonsLocalized(localizedLessons: [])
	
    var body: some View {
		NavigationStack {
			if courseCon.isLoadingAllLessons {
				ProgressView()
			} else {
				List {
					ForEach(allLessonsLocalized.localizedLessons) { localized in
						NavigationLink {
							LocallizedLessonListView(locallizedLesson: localized, currentLanguage: localized.language)
						} label: {
							Text("\(localized.language) \(localized.info)")
						}
					}
				}
				.listStyle(SidebarListStyle())
				.navigationTitle("Courses")
			}
		}
		.onAppear {
			self.getLessonsForLangauges()
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					self.getLessonsForLangauges()
				} label: {
					Label("Fetch all Lessons", systemImage: "arrow.clockwise")
				}
				.buttonStyle(.borderedProminent)
			}
		}
		
    }
	
	func getLessonsForLangauges() {
		for language in loginCon.allLanguages {
			courseCon.getAllLessons(language: language.language) { lessons, error in
				guard error != nil else {
					let newLocalized = LocalizedLessons(
						language: language.language,
						info: language.languageFlag,
						lessons: lessons
					)
					if allLessonsLocalized.localizedLessons.contains(where: { $0.language == newLocalized.language }) {
						allLessonsLocalized.localizedLessons.removeAll(where: { $0.language == newLocalized.language })
					}
					allLessonsLocalized.localizedLessons.append(newLocalized)
					return
				}
			}
		}
	}
}

#Preview {
    AllLessonsListView()
}
