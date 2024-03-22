//
//  InSessionSwitchSubLessonButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionSwitchSubLessonButtonView: View {
	
	var switchLesson: () -> Void
	var isInAdminPanel: Bool = false
	
    var body: some View {
		Button {
			switchLesson()
		} label: {
			if isInAdminPanel {
				Image(systemName: "arrow.turn.up.right")
					.font(.subheadline)
					.padding(8)
					.background {
						RoundedRectangle(cornerRadius: 8)
							.foregroundStyle(.bar)
					}
			} else {
				HStack {
					HStack {
						Spacer()
						Label {
							Image(systemName: "arrow.right")
						} icon: {
							Text("Continue")
						}
						.font(.headline)
						
						Spacer()
					}
					.padding()
					.background {
						RoundedRectangle(cornerRadius: 16)
							.foregroundStyle(.tint)
					}
				}
			}
		}
		.buttonStyle(.plain)
    }
}

#Preview {
	InSessionSwitchSubLessonButtonView(switchLesson: { print("switching")})
}
