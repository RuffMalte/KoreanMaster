//
//  LessonLikeSmallNavButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI
import ConfettiSwiftUI

struct LessonLikeSmallNavButtonView: View {
	
	@State var likedBy: [LikedBy]
	
	@State private var counter = 0
	
    var body: some View {
		Button {
			counter += 1
			//TODO: add logic
		} label: {
			VStack {
				Image(systemName: "heart.fill")
					.font(.title3)
				Text(likedBy.count.description)
					.font(.system(.footnote, design: .monospaced, weight: .regular))
			}
			.foregroundStyle(.secondary)
			.padding(4)
			.background {
				RoundedRectangle(cornerRadius: 5)
					.foregroundStyle(.secondary.opacity(0.2))
			}
		}
		.buttonStyle(.plain)
		.confettiCannon(
			counter: $counter,
			num: 1,
			confettis: [
				.sfSymbol(symbolName: "heart.fill"),
				.sfSymbol(symbolName: "sparkle"),				
			],
			confettiSize: 20,
			rainHeight: 100,
			fadesOut: true,
			radius: 100,
			repetitions: 6,
			repetitionInterval: 0.1
		)
		
    }
}

#Preview {
	LessonLikeSmallNavButtonView(likedBy: LikedBy.multipleExample)
}
