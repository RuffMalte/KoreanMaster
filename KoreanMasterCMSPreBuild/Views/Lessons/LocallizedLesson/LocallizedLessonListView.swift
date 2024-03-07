//
//  LocallizedLessonListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct LocallizedLessonListView: View {
	
	
	@State var locallizedLesson: LocalizedLessons
	
    var body: some View {
		Form {
			List {
				ModifyLocalizedLessonView(localizedLesson: locallizedLesson)

				
				ForEach(locallizedLesson.lessons) { lesson in
					NavigationLink {
						ModifyLessonView(lesson: lesson)
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
	LocallizedLessonListView(locallizedLesson: LocalizedLessons.singleEnglishExample)
}
