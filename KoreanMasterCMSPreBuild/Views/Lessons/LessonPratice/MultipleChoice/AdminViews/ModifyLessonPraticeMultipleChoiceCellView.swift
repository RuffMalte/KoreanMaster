//
//  ModifyLessonPraticeMultipleChoiceCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 17.03.24.
//

import SwiftUI

struct ModifyLessonPraticeMultipleChoiceCellView: View {
	
	@State var multipleChoice: LessonpracticeMultipleChoice
	var removeFuntion: () -> Void

    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				TextField("Question", text: $multipleChoice.question)
				
				VStack(alignment: .leading) {
					Text("Answers")
						.font(.system(.subheadline, design: .rounded, weight: .bold))
						.foregroundStyle(.secondary)
					
					ScrollView(.horizontal) {
						HStack {
							Button {
								let newAnswer = LessonPraticeMultipleChoiceAnswer(answer: "")
								multipleChoice.answers.append(newAnswer)
							} label: {
								Image(systemName: "plus")
									.foregroundStyle(.secondary)
									.font(.system(.headline))
							}
							
							ForEach(multipleChoice.answers) { answer in
								ModifyMultipleChoiceAnswerView(answer: answer) {
									multipleChoice.answers.removeAll(where: { $0.id == answer.id })
								} changeCorrectAction: {
									for a in multipleChoice.answers {
										if a.id != answer.id {
											a.isCorret = false
										} else {
											a.isCorret = true
										}
									}
								}
							}
						}
					}
				}
			}
			Button {
				removeFuntion()
			} label: {
				Image(systemName: "xmark")
			}
		}
		.navigationTitle("Multiple Choice")
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	ModifyLessonPraticeMultipleChoiceCellView(multipleChoice: LessonpracticeMultipleChoice.multipleExample[0], removeFuntion: {print("removing")})
}
