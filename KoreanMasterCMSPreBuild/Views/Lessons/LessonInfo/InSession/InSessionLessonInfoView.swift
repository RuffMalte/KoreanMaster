//
//  InSessionLessonInfoView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonInfoView: View {
	
	@State var lessonInfo: LessonInfo
	
	var switchLesson: () -> Void
	
    var body: some View {
		InSessionLessonHeaderView(title: lessonInfo.lessonName, subtitle: lessonInfo.heading) {
			VStack(spacing: 10) {
				Spacer()
				
				VStack {
					Label("Description", systemImage: "book.fill")
						.font(.system(.title3, design: .rounded, weight: .bold))
					Text(lessonInfo.desc)
						.font(.system(.subheadline, design: .default, weight: .thin))
				}
				
				Spacer()
				
				InSessionSwitchSubLessonButtonView(switchLesson: switchLesson)
				
				
			}
		}
    }
}

#Preview {
	InSessionLessonInfoView(lessonInfo: LessonInfo.detailExample, switchLesson: { print("switching")})
}
