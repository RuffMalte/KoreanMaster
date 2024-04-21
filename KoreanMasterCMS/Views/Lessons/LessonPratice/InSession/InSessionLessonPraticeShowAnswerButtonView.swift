//
//  InSessionLessonPraticeShowAnswerButtonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonPraticeShowAnswerButtonView: View {
	
	@Binding var showNavigationButtons: Bool
	@Binding var hasAnswerBeenSelected: Bool
	
    var body: some View {
		Button {
			withAnimation {
				showNavigationButtons = true
				hasAnswerBeenSelected = true
			}
		} label: {
			HStack {
				Spacer()
				Text("Show Answer")
					.font(.system(.headline, design: .default, weight: .thin))
					.foregroundStyle(.secondary)
				Spacer()
			}
			.padding()
		}
		.buttonStyle(.plain)
    }
}
