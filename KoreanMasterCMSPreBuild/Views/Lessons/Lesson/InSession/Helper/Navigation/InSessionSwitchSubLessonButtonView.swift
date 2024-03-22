//
//  InSessionSwitchSubLessonButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionSwitchSubLessonButtonView: View {
	
	var switchLesson: () -> Void
	var isDone: Bool = false
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
						if isDone {
							Label {
								Image(systemName: "checkmark")
							} icon: {
								Text("Done")
							}
						} else {
							Label {
								Image(systemName: "arrow.right")
							} icon: {
								Text("Continue")
							}
						}
						Spacer()
					}
					.font(.headline)
					.padding()
					.background {
						if isDone {
							RoundedRectangle(cornerRadius: 16)
								.foregroundStyle(.bar)
								.overlay {
									RoundedRectangle(cornerRadius: 16)
										.stroke(.tint, style: StrokeStyle(lineWidth: 3, dash: [20, 5]))
								}
						} else {
							RoundedRectangle(cornerRadius: 16)
								.foregroundStyle(.tint)
						}
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
