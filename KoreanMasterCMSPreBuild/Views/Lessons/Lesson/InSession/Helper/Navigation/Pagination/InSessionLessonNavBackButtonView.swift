//
//  InSessionLessonNavBackButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonNavBackButtonView: View {
	@Binding var currentIndex: Int
	
	var body: some View {
		Button {
			withAnimation {
				currentIndex = max(currentIndex - 1, 0)
			}
		} label: {
			HStack {
				HStack {
					Spacer()
					Label("Previous", systemImage: "chevron.backward")
						.font(.headline)
					Spacer()
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 16)
						.foregroundStyle(.bar)
				}
			}
		}
		.buttonStyle(.plain)
	}
}


