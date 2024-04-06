//
//  ExploreLessonStartButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

struct ExploreLessonStartButtonView: View {
	var isButtonDisabled: Bool = false
	var startLessonFunction: () -> Void
	var xpToGain: Int
	
    var body: some View {
		Button {
			startLessonFunction()
		} label: {
			HStack {
				HStack {
					Spacer()
					HStack(spacing: 5) {
						Text("Start")
						Text("+\(xpToGain) XP")
					}
					.font(.system(.footnote, design: .rounded, weight: .bold))
					
					Spacer()
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(.bar)
						.shadow(radius: 5)
				}
			}
		}
		.disabled(isButtonDisabled)
    }
}

#Preview {
	ExploreLessonStartButtonView(startLessonFunction: { print("Starting lesson") }, xpToGain: 2000)
}
