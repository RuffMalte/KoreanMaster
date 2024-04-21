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
	
	@State private var preSelectedSection: Int?
	@State private var preSelectedUnit: Int?
	@State private var isShowingAddSheet: Bool = false
	var body: some View {
		GeometryReader { geo in
			HStack {
				Group {
					Form {
						List {
							ModifyLocalizedLessonView(localizedLesson: locallizedLesson)
							
							listView
							
						}
					}
				}
				.frame(width: geo.size.width / 2)
				
				ExploreAllLocalizedLessonsView(lessons: locallizedLesson.lessons, currentLanguage: currentLanguage)
				.frame(width: geo.size.width / 2)
			}
		}
 		.navigationTitle(currentLanguage)
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
	
	var listView: some View {
		ForEach(locallizedLesson.getSortedSection().keys.sorted(), id: \.self) { section in
			DisclosureGroup {
				ForEach(locallizedLesson.getSortedSection()[section]?.sorted(by: { $0.lessonInfo.unit < $1.lessonInfo.unit }) ?? [], id: \.id) { lesson in
					NavigationLink {
						ModifyLessonView(lesson: lesson, currentLanguage: currentLanguage)
					} label: {
						LessonDetailSmallCellView(lesson: lesson, currentLanguage: currentLanguage)
					}
				}
			} label: {
				HStack {
					Text("Section: \(section)")
					Spacer()
					NavigationLink {
						ModifyLessonView(
							currentLanguage: currentLanguage,
							preSelectedSection: section,
							preSelectedUnit: locallizedLesson.getSortedSection()[section]?.count ?? 0,
							preSelectedColor: locallizedLesson.getSortedSection()[section]?.first?.lessonInfo.color
						)
					} label: {
						Label("Add Unit", systemImage: "plus")
					}
				}
				.background {
					locallizedLesson.getSortedSection()[section]?.first?.lessonInfo.color.toColor.opacity(0.2)
				}
				.font(.system(.title3, design: .rounded, weight: .bold))
			}
		}
	}
}

#Preview {
	LocallizedLessonListView(locallizedLesson: LocalizedLessons.singleEnglishExample, currentLanguage: "English")
}
