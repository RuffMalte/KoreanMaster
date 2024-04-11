//
//  InSessionLessonMultipleChoiceItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI
import ConfettiSwiftUI

struct InSessionLessonMultipleChoiceItemView: View {
	
	var multipleChoice: LessonpracticeMultipleChoice
	@Binding var showNavigationButtons: Bool
	@Binding var hasAnswerBeenSelected: Bool
	
	@State private var confettiCon: Int = 0
	
	@State private var selectedAnswer: Int?
	
	var body: some View {
		VStack {
			Spacer()
			Text(multipleChoice.question)
				.font(.system(.title2, design: .rounded, weight: .bold))
				.padding()
			
			Spacer()
			ForEach(multipleChoice.answers.indices, id: \.self) { index in
				Button(action: {
					hasAnswerBeenSelected = true
					showNavigationButtons = true
					
					selectedAnswer = index
					if multipleChoice.answers[index].isCorret {
						confettiCon += 1
					}
					
				}) {
					HStack {
						Spacer()
						Text(multipleChoice.answers[index].answer)
							.font(.system(.headline, design: .default, weight: .regular))
							.foregroundStyle (hasAnswerBeenSelected ? .white : .primary)
						Spacer()
					}
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

				.disabled(hasAnswerBeenSelected)
				.confettiCannon(counter: $confettiCon)
			}
		}
	}
		
	func getButtonColor(for index: Int) -> Color {
		if hasAnswerBeenSelected {
			if multipleChoice.answers[index].isCorret {
				return Color.green
			} else {
				return Color.red
			}
		}
		return Color.primary
	}
}

#Preview {
	InSessionLessonMultipleChoiceItemView(multipleChoice: LessonpracticeMultipleChoice.multipleExample[0], showNavigationButtons: .constant(false), hasAnswerBeenSelected: .constant(false))
}
