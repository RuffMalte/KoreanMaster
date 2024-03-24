//
//  ExploreAllLocalizedLessonsView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 23.03.24.
//

import SwiftUI

struct ExploreAllLocalizedLessonsView: View {
	
	var locallizedLesson: LocalizedLessons
	
    var body: some View {
		HStack {
			Spacer()
			ScrollView {
				VStack(spacing: 20) {
					ForEach(Array(locallizedLesson.lessons.enumerated()), id: \.element.id) { index, lesson in
						HStack {
							if index % 4 == 0 {
								// Left aligned
								ExploreLessonCellView(lesson: lesson)
									.frame(width: 100, height: 100)
								Spacer()
							} else if index % 4 == 1 || index % 4 == 3 {
								// Middle aligned
								Spacer()
								ExploreLessonCellView(lesson: lesson)
									.frame(width: 100, height: 100)
								Spacer()
							} else if index % 4 == 2 {
								// Right aligned
								Spacer()
								ExploreLessonCellView(lesson: lesson)
									.frame(width: 100, height: 100)
							}
						}
					}
				}
				.padding()
			}
			.frame(width: 250)
			
			
			
			Spacer()
		}
		.background {
			Color.tertiaryBackground
				.ignoresSafeArea()
		}
	}
}





