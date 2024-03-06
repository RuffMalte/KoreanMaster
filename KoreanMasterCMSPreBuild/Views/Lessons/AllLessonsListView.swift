//
//  AllLessonsListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 06.03.24.
//

import SwiftUI

struct AllLessonsListView: View {
	
	
	@EnvironmentObject var courseCon: CoursesController
	
	@State private var lesson: Lesson?
	
    var body: some View {
		NavigationStack {
			List {
				HStack {
					Button {
						courseCon.addNewLesson(lesson: Lesson.detailExample, language: "English") { finished in
							if finished {
								print("Lesson added")
							} else {
								print("Lesson not added")
							}
						}
					} label: {
						Label("Add Course", systemImage: "plus.circle.fill")
					}
					Button {
						courseCon.getFullLesson(lessonName: "Lesson 1", language: "English") { lesson, error in
							if let lesson = lesson {
								self.lesson = lesson
							} else {
								print("Error: \(error)")
							}
						}
					} label: {
						Label("Get first Lesson", systemImage: "arrow.down.circle.fill")
					}
				}
				
				if let lesson = lesson {
					JSONView(model: lesson)
				}
				
			}
			
			
		}
    }
}

#Preview {
    AllLessonsListView()
}
