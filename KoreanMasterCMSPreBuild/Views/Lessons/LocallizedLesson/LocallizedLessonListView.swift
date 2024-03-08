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
    }
}

#Preview {
	LocallizedLessonListView(locallizedLesson: LocalizedLessons.singleEnglishExample, currentLanguage: "English")
}
