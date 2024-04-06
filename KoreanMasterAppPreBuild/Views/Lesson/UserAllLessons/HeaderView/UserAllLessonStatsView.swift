//
//  UserAllLessonStatsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 28.03.24.
//

import SwiftUI
import SwiftData

struct UserAllLessonStatsView: View {
	
	var currentUser: FirestoreUser
	
	@Query var localVocabs: [UserLocalVocab]
	@Environment(\.modelContext) var modelContext
	
    var body: some View {
		HStack {
			Spacer()
			HStack(spacing: 30) {
				UserStatisticsItemView(icon: "flame.fill", iconColor: .orange, title: currentUser.daysStreak.description, showBackgroundRectangle: false)
					
				
				UserStatisticsItemView(icon: "sparkles", iconColor: .yellow, title: currentUser.totalXP.description, showBackgroundRectangle: false)
				
				UserStatisticsItemView(icon: "character.book.closed.fill", iconColor: .blue, title: localVocabs.filter { $0.isMastered }.count.description, showBackgroundRectangle: false)
				
				UserStatisticsItemView(icon: "checkmark", iconColor: .green, title: currentUser.compeltedLessonsIDS.count.description, showBackgroundRectangle: false)
				
			}
			.font(.system(.title3, design: .rounded, weight: .bold))
			.padding()
			.lineLimit(1)
			
			Spacer()
		}
    }
}

#Preview {
	VStack {
		UserAllLessonStatsView(currentUser: FirestoreUser.singleExample)
			.withEnvironmentObjects()
			
		ExploreAllLocalizedLessonsView(lessons: [Lesson.detailExample], currentLanguage: "English")
	}
}
