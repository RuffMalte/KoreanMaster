//
//  UserStatisticsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI

struct UserStatisticsView: View {
    var body: some View {
		LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
			UserStatisticsItemView(icon: "flame.fill", iconColor: .orange, title: "69", subHeader: "Day streak")
				
			UserStatisticsItemView(icon: "sparkles", iconColor: .yellow, title: "20000", subHeader: "Total XP")
			
		})
    }
}

#Preview {
    UserStatisticsView()
}
