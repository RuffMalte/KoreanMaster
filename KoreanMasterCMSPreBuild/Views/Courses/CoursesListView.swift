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
						Button {
							coursesCon.createCourse(course: Course.detailExample)
						} label: {
							Label("Create new course", systemImage: "plus")
						}
						
						Button {
							coursesCon.getCourseLocalizedInfoTEST(courseName: Course.detailExample.getCourseComputedName(), language: "German") { locLesson in
								if let locLesson = locLesson {
									self.locLesson = locLesson
								} else {
									print("Error getting localized lesson")
								}
								
							}
						} label: {
							Label("Get all courses", systemImage: "arrow.down.circle")
						}
						
						Button {
							coursesCon.getAllCoursesLocalized(sectionFilter: 1, language: "German") { courses in
								self.courses = courses
							}
						} label: {
							Label("Get all Section 1 courses", systemImage: "1.circle.fill")
						}
						
					}
					
					if let locLesson = locLesson {
						NavigationLink {
							JSONView(model: locLesson)
						} label: {
							Text(locLesson.title)
						}
					}
					
					ForEach(courses) { course in
						NavigationLink {
							JSONView(model: course)
						} label: {
							Text(course.getCourseComputedName())
						}
					}
					
				}
			}
		}
    }
}

#Preview {
    CoursesListView()
}
