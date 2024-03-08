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
				TabView {
					ForEach(allLessonsLocalized.localizedLessons) { localized in
						LocallizedLessonListView(locallizedLesson: localized, currentLanguage: localized.language)
							.tabItem {
								Text("\(localized.language) \(localized.info)")
							}
					
					}
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					courseCon.SaveLesson(lesson: Lesson.detailExample, language: "English") { bool in
						if bool {
							print("Lesson added")
						} else {
							print("Lesson not added")
						}
					}
				} label: {
					Label("Add new Lesson", systemImage: "plus")
				}
			}
			
			ToolbarItem(placement: .primaryAction) {
				Button {
					for language in loginCon.allLanguages {
						courseCon.getAllLessons(language: language.language) { lessons, error in
							guard error != nil else {
								let newLocalized = LocalizedLessons(
									language: language.language,
									info: language.languageFlag,
									lessons: lessons
								)
								allLessonsLocalized.localizedLessons.append(newLocalized)
								return
							}
						}
					}
				} label: {
					Label("Fetch all Lessons", systemImage: "arrow.clockwise")
				}
				.buttonStyle(.borderedProminent)
			}
		}
		
    }
}

#Preview {
    AllLessonsListView()
}
