//
//  LessonDetailSmallCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct LessonDetailSmallCellView: View {
	
	var lesson: Lesson
	
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				VStack(alignment: .leading) {
					Text(lesson.lessonInfo.lessonName)
					Text(lesson.lessonInfo.heading)
						.foregroundStyle(.secondary)
						.font(.system(.footnote, design: .rounded, weight: .bold))
				}
				Spacer()
				
				Text("\(lesson.lessonInfo.section) - \(lesson.lessonInfo.unit)")
					.foregroundStyle(.secondary)
					.font(.system(.footnote, design: .rounded, weight: .bold))
			}
			
			HStack(alignment: .firstTextBaseline) {
				ForEach(lesson.lessonTag.lessonTagItems ?? []) { tag in
					LessonTagSmallView(lessonTag: tag)
				}

				
				
			}
			
		}
    }
}

#Preview {
	LessonDetailSmallCellView(lesson: Lesson.detailExample)
}
