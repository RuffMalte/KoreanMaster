//
//  CoursesListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct CoursesListView: View {
	
	@EnvironmentObject var coursesCon: CoursesController
	
	
	@State private var locLesson: LocalizedLesson?
	
	@State var courses: [Course] = []
	
    var body: some View {
		NavigationStack {
			Form {
				List {
					HStack {
						NavigationLink {
							ModifyCourseView()
						} label: {
							Label("Create new course", systemImage: "plus")
						}
						
						
						Button {
							coursesCon.getAllCoursesLocalized(language: "German") { courses in
								self.courses = courses
							}
						} label: {
							Label("Get all Section 1 courses", systemImage: "1.circle.fill")
						}
						
					}
					
					
					ForEach(courses) { course in
						NavigationLink {
							ModifyCourseView(course: course)
						} label: {
							CourseSmallDetailCellView(course: course)
						}
					}
					
				}
			}
			.navigationTitle("Courses")
			.toolbar {
				if !courses.isEmpty {
					NavigationLink {
						JSONView(model: courses)
					} label: {
						Label("JSON", systemImage: "ellipsis.curlybraces")
					}
				}
			}
		}
    }
}

#Preview {
    CoursesListView()
}
