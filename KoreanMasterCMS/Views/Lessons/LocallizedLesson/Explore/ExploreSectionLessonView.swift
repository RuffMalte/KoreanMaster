//
//  ExploreSectionLessonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

struct ExploreSectionLessonView: View {
	
	var locallizedLesson: LocalizedLessons
	@State var currentLanguage: String

	
    var body: some View {
		VStack {
			
			List {
				ForEach(locallizedLesson.getSortedSection().keys.sorted(), id: \.self) { section in
					NavigationLink {
						ExploreAllLocalizedLessonsView(lessons: locallizedLesson.getSortedSection()[section]?.sorted(by: { $0.lessonInfo.unit < $1.lessonInfo.unit }) ?? [], currentLanguage: currentLanguage)
					} label: {
						HStack {
							Text("Section: \(section)")
							//TODO: ADD a View here
						}
						.font(.system(.title3, design: .rounded, weight: .bold))
					}
					.buttonStyle(.plain)
				}
				
			}
			
			
			
			
			
			.navigationTitle("Sections")
		}
    }
}

#Preview {
	ExploreSectionLessonView(locallizedLesson: LocalizedLessons.singleEnglishExample, currentLanguage: "English")
}
