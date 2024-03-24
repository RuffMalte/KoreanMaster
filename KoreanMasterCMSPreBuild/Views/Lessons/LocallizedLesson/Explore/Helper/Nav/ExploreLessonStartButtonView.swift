//
//  ExploreLessonStartButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

struct ExploreLessonStartButtonView: View {
	
	var startLessonFunction: () -> Void
	var xpToGain: Int
	
    var body: some View {
		Button {
			startLessonFunction()
		} label: {
			HStack {
				HStack {
					Spacer()
					Label {
						Image(systemName: "signpost.right.fill")
					} icon: {
						HStack(spacing: 5) {
							Text("Start")
							Text("+\(xpToGain) XP")
						}
					}
					.font(.headline)
					
					Spacer()
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(.bar)
				}
			}
			.shadow(radius: 5)
		}
    }
}

#Preview {
	ExploreLessonStartButtonView(startLessonFunction: { print("Starting lesson") }, xpToGain: 2000)
}