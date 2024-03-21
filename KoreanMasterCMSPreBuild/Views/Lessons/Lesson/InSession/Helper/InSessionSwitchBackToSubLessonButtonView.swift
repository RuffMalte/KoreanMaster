//
//  InSessionSwitchBackToSubLessonButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionSwitchBackToSubLessonButtonView: View {
	
	var switchLesson: () -> Void
	
    var body: some View {
		Button {
			switchLesson()
		} label: {
			Image(systemName: "arrow.turn.up.left")
		}
		.buttonStyle(.bordered)
    }
}

#Preview {
	InSessionSwitchBackToSubLessonButtonView(switchLesson: {print("switching")})
}
