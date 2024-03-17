//
//  LocallizedLessonListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct LocallizedLessonListView: View {
	
	
	@State var locallizedLesson: LocalizedLessons
	@State var currentLanguage: String
	@EnvironmentObject var courseCon: CoursesController
	
    var body: some View {
		Form {
			List {
				ModifyLocalizedLessonView(localizedLesson: locallizedLesson)

				
				ForEach(locallizedLesson.lessons) { lesson in
					NavigationLink {
						ModifyLessonView(lesson: lesson, currentLanguage: currentLanguage)
					} label: {
						LessonDetailSmallCellView(lesson: lesson)
					}
				}
			}
		}
 		.navigationTitle(locallizedLesson.language)
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					courseCon.SaveLesson(lesson: Lesson.detailExample, language: currentLanguage) { bool in
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
		}
    }
}

#Preview {
	LocallizedLessonListView(locallizedLesson: LocalizedLessons.singleEnglishExample, currentLanguage: "English")
}
