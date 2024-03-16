//
//  LessonTagSmallView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 05.03.24.
//

import SwiftUI

struct LessonTagSmallView: View {
	
	var lessonTag: LessonTagItem
	
    var body: some View {
        Text(lessonTag.tagName)
			.font(.system(.footnote, design: .rounded, weight: .bold))
			.foregroundStyle(lessonTag.tagColor.toColor)
			.padding(5)
			.background {
				RoundedRectangle(cornerRadius: 5)
					.foregroundStyle(lessonTag.tagColor.toColor.opacity(0.2))
			}
    }
}

#Preview {
	LessonTagSmallView(lessonTag: LessonTagItem.multipleExamples[0])
}
