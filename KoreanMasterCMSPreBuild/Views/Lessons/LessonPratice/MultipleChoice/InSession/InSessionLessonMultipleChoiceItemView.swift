//
//  InSessionLessonMultipleChoiceItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonMultipleChoiceItemView: View {
	
	var multipleChoice: LessonpracticeMultipleChoice
	
    var body: some View {
		VStack {
			Text(multipleChoice.question)
				.font(.title)
				.padding()
			
			ForEach(multipleChoice.answers.indices, id: \.self) { index in
				Button {
					if multipleChoice.answers[index].isCorret{
						print("Correct")
					} else {
						print("Wrong")
					}
				} label: {
					Text(multipleChoice.answers[index].answer)
						.font(.title2)
						.padding()
				}
			}
		}
    }
}
