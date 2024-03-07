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
        Text("#" + lessonTag.tagName)
			.font(.system(.footnote, design: .rounded, weight: .bold))
			.foregroundStyle(.red)
			.padding(5)
			.background {
				RoundedRectangle(cornerRadius: 5)
					.foregroundStyle(.red.opacity(0.2))
			}
    }
}

#Preview {
	LessonTagSmallView(lessonTag: LessonTagItem.multipleExamples[0])
}
