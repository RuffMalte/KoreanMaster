//
//  AfterLessonSummaryView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 07.04.24.
//

import SwiftUI

struct AfterLessonSummaryView: View {
	
	var afterLesson: AfterLessonModel
	var onEnd: () -> Void


	
    var body: some View {
		VStack {
			
			
			Spacer()
			
			
			Text("You have gained:")
				.font(.system(.title3, design: .rounded, weight: .bold))
				.foregroundStyle(.primary)
				.padding()
			
			
			
			UserStatisticsItemView(icon: "sparkles", iconColor: .yellow, title: "+\(afterLesson.lesson.lessonInfo.xpToGain) XP", showBackgroundRectangle: false)
			
			
			Spacer()
			
			Button {
				onEnd()
			} label: {
				HStack {
					Spacer()
					Text("Close")
					Spacer()
				}
				.font(.headline)
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 16)
						.foregroundStyle(.tint)
						.shadow(radius: 5)
				}
			}
			.buttonStyle(.plain)
		}
		.padding()
		.frame(width: 300, height: 250)
		.background {
			RoundedRectangle(cornerRadius: 16)
				.foregroundStyle(.bar)
				.shadow(radius: 5)
		}
    }
}

#Preview {
	AfterLessonSummaryView(afterLesson: AfterLessonModel(lesson: Lesson.detailExample, user: FirestoreUser.singleExample, hasNewStreakItem: true), onEnd: {})
}
