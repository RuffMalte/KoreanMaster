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

				
				ForEach(locallizedLesson.lessons, id: \.id) { lesson in
					NavigationLink {
						ModifyLessonView(lesson: lesson, currentLanguage: currentLanguage)
					} label: {
						LessonDetailSmallCellView(lesson: lesson, currentLanguage: currentLanguage)
					}
				}
			}
		}
 		.navigationTitle(locallizedLesson.language)
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				NavigationLink {
					ModifyLessonView(currentLanguage: currentLanguage)
				} label: {
					Label("Add Lesson", systemImage: "plus")
				}
				
			}
		}
    }
}

#Preview {
	LocallizedLessonListView(locallizedLesson: LocalizedLessons.singleEnglishExample, currentLanguage: "English")
}
