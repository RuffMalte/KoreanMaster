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
	
	@State private var showProgressView = false
	
    var body: some View {
		Button {
			withAnimation {
				self.showProgressView = true
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 + Double.random(in: 0.0...0.1)) {
					self.showProgressView = false
					
					switchLesson()
				}
			}
		} label: {
			if isInAdminPanel {
				Image(systemName: "arrow.turn.up.right")
					.font(.subheadline)
					.padding(8)
					.background {
						RoundedRectangle(cornerRadius: 8)
							.foregroundStyle(.bar)
					}
					.shadow(radius: 5)
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
					.shadow(radius: 5)
				}
			}
		}
		.buttonStyle(.plain)
		.overlay(
			ZStack {
				if showProgressView {
					RoundedRectangle(cornerRadius: 16)
						.foregroundStyle(.tint)
					ProgressView()
				}
			}
		)
    }
}

#Preview {
	InSessionSwitchSubLessonButtonView(switchLesson: { print("switching")})
}
