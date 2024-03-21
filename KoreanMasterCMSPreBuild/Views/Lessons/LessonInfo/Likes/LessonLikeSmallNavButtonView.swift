//
//  LessonLikeSmallNavButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct LessonLikeSmallNavButtonView: View {
	
	@State var likedBy: [LikedBy]
	
    var body: some View {
		Button {
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
    }
}

#Preview {
	LessonLikeSmallNavButtonView(likedBy: LikedBy.multipleExample)
}
