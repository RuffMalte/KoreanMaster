//
//  UserStatisticsItemView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI

struct UserStatisticsItemView: View {
	
	var icon: String
	var iconColor: Color
	var title: String
	var subHeader: String
	
    var body: some View {
		HStack {
			Label {
				VStack(alignment: .leading) {
					Text(title)
						.font(.system(.headline, design: .monospaced, weight: .bold))
						.foregroundStyle(.primary)
					Text(subHeader)
						.font(.system(.subheadline, design: .rounded, weight: .regular))
						.foregroundStyle(.secondary)
				}
			} icon: {
				Image(systemName: icon)
					.foregroundStyle(iconColor.gradient)
					.font(.system(.headline, design: .default, weight: .bold))
			}
			Spacer()
		}
		.padding(12)
		.background {
			RoundedRectangle(cornerRadius: 16)
				.foregroundStyle(.bar)
				.shadow(radius: 3)
		}
    }
}

#Preview {
	UserStatisticsItemView(icon: "flame.fill", iconColor: .yellow, title: "69", subHeader: "Day streak")
		.padding()
}
