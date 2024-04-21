//
//  VocabModeItemView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

struct VocabModeItemView: View {
	
	var isSelected: Bool = true
	
	var icon: String
	var color: ColorEnum
	var title: String
	
    var body: some View {
		VStack {
			
			Image(systemName: icon)
			.font(.system(.title3, design: .rounded, weight: .bold))
			.frame(width: 50, height: 50)
			.background {
				RoundedRectangle(cornerRadius: 8)
					.shadow(radius: 5)
					.foregroundStyle(color.toColor.opacity(0.8))
			}
			
			Text(title)
				.font(.headline)
				.foregroundColor(.primary)
		}
		.padding(6)
		.background {
			if isSelected {
				RoundedRectangle(cornerRadius: 8)
					.stroke(
						Color.accentColor,
						style: StrokeStyle(
							lineWidth: 3,
							lineCap: .round,
							lineJoin: .miter,
							miterLimit: 0,
							dash: [5, 10],
							dashPhase: 0
						)
					)
			}
		}
		
		
    }
}

#Preview {
	HStack(spacing: 20) {
		VocabModeItemView(icon: "book", color: .red, title: "ANKI")
		VocabModeItemView(icon: "book", color: .red, title: "ANKI")
		VocabModeItemView(icon: "book", color: .red, title: "ANKI")
		VocabModeItemView(icon: "book", color: .red, title: "ANKI")
	}
	
}
