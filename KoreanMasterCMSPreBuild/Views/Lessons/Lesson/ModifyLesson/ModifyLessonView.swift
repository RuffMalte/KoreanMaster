//
//  ModifyLessonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

///if the optional is not set it will create a new lesson
struct ModifyLessonView: View {
	
	@State var lesson: Lesson
	@EnvironmentObject var courseCon: CoursesController

	
    var body: some View {
		Form {
			
			List {
				ModifyLessonInfoView(lessonInfo: lesson.lessonInfo)
				
				
				ModifyLessonTagsView(lessonTag: lesson.lessonTag)
				
				
				
				
			}
		}
		.textFieldStyle(.roundedBorder)
		.navigationTitle(lesson.lessonInfo.lessonName)		
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					courseCon.SaveLesson(lesson: lesson, language: "English") { bool in
						if bool {
							print("Lesson added")
						} else {
							print("Lesson not added")
						}
					}
				} label: {
					Label("Save", systemImage: "square.and.arrow.down")
				}
			}
		}
	}
			
			
			
			
			
}

#Preview {
	ModifyLessonView(lesson: Lesson.detailExample)
}
