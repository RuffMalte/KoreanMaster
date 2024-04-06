//
//  LearnVocabStartButtonView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

struct LearnVocabStartButtonView: View {
	
	@Binding var toggleLearnVocabSheet: Bool
	
    var body: some View {
		Button {
			toggleLearnVocabSheet.toggle()
		} label: {
			HStack {
				Spacer()
				Label("Learn", systemImage: "book")
					.foregroundStyle(.primary)
					.font(.system(.headline, design: .rounded, weight: .bold))
				Spacer()
			}
			.padding()
			.frame(height: 50)
			.background {
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(.tint)
					.shadow(radius: 5)
			}
		}
		.buttonStyle(.plain)
    }
}

#Preview {
	LearnVocabStartButtonView(toggleLearnVocabSheet: .constant(false))
}
