//
//  LessonCommentSmallNavButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct LessonCommentSmallNavButtonView: View {
	
	var commentedBy: [CommentedBy]
	
    var body: some View {
		NavigationLink {
			Text("Not implemented yet!")
		} label: {
			VStack {
				Image(systemName: "text.bubble.fill")
					.font(.title3)
				Text(commentedBy.count.description)
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
	LessonCommentSmallNavButtonView(commentedBy: CommentedBy.multipleExample)
}
