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
	
	var body: some View {
		VStack {
			Text(multipleChoice.question)
				.font(.title)
				.padding()
			
			ForEach(multipleChoice.answers.indices, id: \.self) { index in
				Button(action: {
					hasAnswerBeenSelected = true
					showNavigationButtons = true
					
					if multipleChoice.answers[index].isCorret {
						confettiCon += 1
					}
					
				}) {
					Text(multipleChoice.answers[index].answer)
						.font(.title2)
						.foregroundStyle (getButtonColor(for: index))
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

