//
//  InSessionSwitchSubLessonButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionSwitchSubLessonButtonView: View {
	
	var switchLesson: () -> Void

    var body: some View {
		Button {
			switchLesson()
		} label: {
			Label("Continue", systemImage: "arrow.right.circle.fill")
		}
		.buttonStyle(.borderedProminent)
    }
}

#Preview {
	InSessionSwitchSubLessonButtonView(switchLesson: { print("switching")})
}
