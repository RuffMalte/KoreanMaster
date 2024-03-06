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
			.foregroundStyle(.red)
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(.red.opacity(0.2))
			}
    }
}

#Preview {
	LessonTagSmallView(lessonTag: LessonTagItem.multipleExamples[0])
}
