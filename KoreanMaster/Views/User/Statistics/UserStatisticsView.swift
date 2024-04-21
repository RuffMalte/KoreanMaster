//
//  UserStatisticsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI
import SwiftData

struct UserStatisticsView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
	@Query var localVocabs: [UserLocalVocab]
	@Environment(\.modelContext) var modelContext
	
    var body: some View {
		LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
			UserStatisticsItemView(icon: "flame.fill", iconColor: getStreakColorItem(), title: loginCon.currentFirestoreUser?.daysStreak.description ?? "0", subHeader: "Day streak")
				
			UserStatisticsItemView(icon: "sparkles", iconColor: .yellow, title: loginCon.currentFirestoreUser?.totalXP.description ?? "0", subHeader: "Total XP")
			
			
			UserStatisticsItemView(icon: "character.book.closed.fill", iconColor: .blue, title: localVocabs.filter { $0.isMastered }.count.description, subHeader: "Vocab masterd")
			
			UserStatisticsItemView(icon: "checkmark", iconColor: .green, title: loginCon.currentFirestoreUser?.compeltedLessonsIDS.count.description ?? "0", subHeader: "Lessons done")
		})
    }
	func getStreakColorItem() -> Color {
		let today = Date()
		
		if let lastStreak = loginCon.currentFirestoreUser?.streaks.last {
			if Calendar.current.isDate(lastStreak.date, inSameDayAs: today) {
				return .orange
			}
		}
		return .gray
	}
}

#Preview {
    UserStatisticsView()
		.padding()
		.withEnvironmentObjects()
}
