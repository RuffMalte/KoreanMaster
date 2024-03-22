//
//  InSessionLessonPraticeSentenceBuildingItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI
import ConfettiSwiftUI

struct InSessionLessonPraticeSentenceBuildingItemView: View {
	
	var sentenceB: LessonpracticeSentenceBuilding
	@Binding var showNavigationButtons: Bool
	@Binding var hasAnswerBeenSelected: Bool
	
	@State private var confettiCon: Int = 0
	
    var body: some View {
		VStack {
			Spacer()
			
			Text(sentenceB.question)
				.font(.title)
				.padding()
			
			Spacer()
			
			VStack {
				ForEach(sentenceB.answers.indices, id: \.self) { index in
					Button(action: {
						hasAnswerBeenSelected = true
						showNavigationButtons = true
						
						if sentenceB.answers[index] == sentenceB.correctAnswer {
							confettiCon += 1
						}
						
					}) {
						HStack {
							Spacer()
							Text(sentenceB.answers[index])
								.font(.title2)
							Spacer()
						}
						.padding()
						.background {
							if hasAnswerBeenSelected {
								RoundedRectangle(cornerRadius: 16)
									.foregroundStyle(getButtonColor(for: index))
							} else {
								RoundedRectangle(cornerRadius: 16)
									.foregroundStyle(.bar)
							}
						}
					}
					.disabled(hasAnswerBeenSelected)
					.confettiCannon(counter: $confettiCon)
					.buttonStyle(.plain)
				}
			}
			
			Spacer()
			
		}
    }
	func getButtonColor(for index: Int) -> Color {
		if hasAnswerBeenSelected {
			if sentenceB.answers[index] == sentenceB.correctAnswer {
				return Color.green
			} else {
				return Color.red
			}
		}
		return Color.primary
	}
}
