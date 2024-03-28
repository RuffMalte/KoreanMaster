//
//  UserStatisticsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI

struct UserStatisticsView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
		LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
			UserStatisticsItemView(icon: "flame.fill", iconColor: .orange, title: loginCon.currentFirestoreUser?.daysStreak.description ?? "0", subHeader: "Day streak")
				
			UserStatisticsItemView(icon: "sparkles", iconColor: .yellow, title: loginCon.currentFirestoreUser?.totalXP.description ?? "0", subHeader: "Total XP")
			
			
			UserStatisticsItemView(icon: "character.book.closed.fill", iconColor: .blue, title: "TODO", subHeader: "Vocab masterd")
			
			UserStatisticsItemView(icon: "checkmark", iconColor: .green, title: loginCon.currentFirestoreUser?.compeltedLessonsIDS.count.description ?? "0", subHeader: "Lessons done")
		})
    }
}

#Preview {
    UserStatisticsView()
		.padding()
		.withEnvironmentObjects()
}
