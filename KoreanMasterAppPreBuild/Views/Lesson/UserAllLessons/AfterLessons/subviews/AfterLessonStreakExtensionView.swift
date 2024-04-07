//
//  AfterLessonStreakExtensionView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 07.04.24.
//

import SwiftUI

struct AfterLessonStreakExtensionView: View {
	
	var afterLesson: AfterLessonModel
	var onEnd: () -> Void

	@State private var toggleToSummary = false
	
	private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
		let calendar = Calendar.current
		return calendar.isDate(date1, inSameDayAs: date2)
	}
	
	private var lastSevenDays: [Date] {
		let calendar = Calendar.current
		return (0..<7).map { calendar.date(byAdding: .day, value: -$0, to: Date())! }.reversed()
	}
	
	
    var body: some View {
		VStack {	
			if toggleToSummary {
				AfterLessonSummaryView(afterLesson: afterLesson, onEnd: onEnd)
			} else {
				VStack {
					Spacer()
					UserStatisticsItemView(icon: "flame.fill", iconColor: .yellow, title: "\(afterLesson.user.daysStreak)  Day Streak", showBackgroundRectangle: false)
						.padding()
						.font(.title3)
					
					HStack {
						ForEach(lastSevenDays, id: \.self) { day in
							Text(day, format: .dateTime.day(.defaultDigits))
								.foregroundStyle(.primary)
								.padding(8)
								.font(.system(.title3, design: .monospaced, weight: .black))
								.background {
									if afterLesson.user.streaks.contains(where: { self.isSameDay($0.date, day) }) {
										RoundedRectangle(cornerRadius: 8)
											.foregroundStyle(.tint.opacity(0.5))
									} else {
										RoundedRectangle(cornerRadius: 8)
											.foregroundStyle(.ultraThinMaterial)
									}
								}
							
						}
					}
					
					Spacer()
					
					Button {
						withAnimation {
							toggleToSummary = true
						}
					} label: {
						HStack {
							Spacer()
							Text("Next")
							Spacer()
						}
						.font(.headline)
						.padding()
						.background {
							RoundedRectangle(cornerRadius: 8)
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
    }
}

#Preview {
	AfterLessonStreakExtensionView(afterLesson: AfterLessonModel(lesson: Lesson.detailExample, user: FirestoreUser.singleExample, hasNewStreakItem: true), onEnd: {})
}
