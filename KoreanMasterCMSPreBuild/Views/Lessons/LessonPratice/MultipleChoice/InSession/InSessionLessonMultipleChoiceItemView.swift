//
//  InSessionLessonMultipleChoiceItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonMultipleChoiceItemView: View {
	
	var multipleChoice: LessonpracticeMultipleChoice
	@Binding var showNavigationButtons: Bool
	@Binding var hasAnswerBeenSelected: Bool
	
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
						print("Correct")
					} else {
						print("Wrong")
					}
				}) {
					Text(multipleChoice.answers[index].answer)
						.font(.title2)
				}
				.disabled(hasAnswerBeenSelected)
			}
		}
	}
}

