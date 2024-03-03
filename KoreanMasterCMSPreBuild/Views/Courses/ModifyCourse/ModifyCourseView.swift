//
//  ModifyCourseView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 03.03.24.
//

import SwiftUI

struct ModifyCourseView: View {
	
	@EnvironmentObject var coursesCon: CoursesController
	@EnvironmentObject var loginCon: LoginController
	
	var course: Course?
	
	@State var workingCourse: Course = Course.emptyCourse
	
    var body: some View {
		VStack {
			if coursesCon.isLoadingCourse {
				ProgressView()
			} else {
				
				VStack {
					TextField("Section", value: $workingCourse.section, formatter: NumberFormatter())
					
					TextField("Unit", value: $workingCourse.unit, formatter: NumberFormatter())
					
					Text(workingCourse.id)
						.font(.caption)
						.foregroundStyle(.secondary)
						.contextMenu {
							Button {
								PasteboardController().copyToPasteboard(string: workingCourse.id)
							} label: {
								Label("Copy id", systemImage: "doc.on.doc")
									.labelStyle(.titleAndIcon)
							}
						}
				}
				.padding()
				.textFieldStyle(.roundedBorder)
				
				TabView {
					ForEach(loginCon.allLanguages) { lang in
						ModifyCourseLocalizedView(localizedLesson: getTest(lang: lang))
							.tabItem {
								LanguageSmallDetailCellView(language: lang)
							}
						
					}
					
				}
			}
		}
		.navigationTitle(course == nil ? "Create new course" : "Modify course")
		.onAppear {
			if let course = course {
				workingCourse = course
			}
			
			coursesCon.getCourseFullDetail(courseName: workingCourse.getCourseComputedName(), languages: loginCon.allLanguages) { course in
				self.workingCourse = course ?? Course.emptyCourse
				
				for loca in workingCourse.localizedLessons ?? [] {
					print(loca.title)
					for pages in loca.pages ?? [] {
						print(pages.pageTitle)
					}
				}
			}
		}
		.overlay(content: {
			if coursesCon.isLoadingCourse {
				Color.white
			}
		})
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				NavigationLink {
					JSONView(model: workingCourse)
				} label: {
					Label("JSON", systemImage: "ellipsis.curlybraces")
				}

			}
		}
    }
	
	func getTest(lang: CourseLanguage) -> LocalizedLesson {
		for loc in workingCourse.localizedLessons ?? [] {
			if loc.language == lang.language {
				return loc
			}
		}
		let newLoc = LocalizedLesson.emptyLocalizedLesson
		newLoc.language = lang.language
		return newLoc
	}
}

#Preview {
    ModifyCourseView()
}
