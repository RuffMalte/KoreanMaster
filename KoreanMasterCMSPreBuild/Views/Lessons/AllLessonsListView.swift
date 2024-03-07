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
	@State private var lessons: [Lesson] = []
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(lessons) { lesson in
					NavigationLink {
						JSONView(model: lesson)
					} label: {
						Text(lesson.lessonInfo.lessonName)
					}

				}
				
				
			}
			.onAppear {
				courseCon.getAllLessons(language: "English") { lessons, error in
					guard let error = error else {
						self.lessons = lessons
						return
					}
				}
			}
			
		}
    }
}

#Preview {
    AllLessonsListView()
}
