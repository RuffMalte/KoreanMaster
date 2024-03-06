//
//  AllLessonsListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 06.03.24.
//

import SwiftUI

struct AllLessonsListView: View {
	
	
	@EnvironmentObject var courseCon: CoursesController
	
	
	
    var body: some View {
		NavigationStack {
			List {
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
				
				
				
			}
			
			
		}
    }
}

#Preview {
    AllLessonsListView()
}
