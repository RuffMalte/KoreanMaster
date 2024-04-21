//
//  InSessionLessonNavNextButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonNavNextButtonView: View {
	
	@Binding var currentIndex: Int
	var amount: Int
	
    var body: some View {
		Button {
			withAnimation {
				currentIndex = min(currentIndex + 1, amount - 1)
			}
		} label: {
			HStack {
				HStack {
					Spacer()
					Label {
						Image(systemName: "chevron.forward")
					} icon: {
						Text("Next")
					}
					.font(.headline)
					
					Spacer()
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 16)
						.foregroundStyle(.bar)
						.shadow(radius: 5)
				}
			}
		}
		.buttonStyle(.plain)

    }
}
