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
				HStack {
					TextField("Correct Answer", text: $multipleChoice.correctAnswer)
					Button {
						TranslationController().getTranslation(for: multipleChoice.correctAnswer, targetLang: "KO") { result, error in
							guard error != nil else {
								if let result = result {
									multipleChoice.correctAnswer = result
								}
								return
							}
						}
					} label: {
						Label("Translate into Korean", systemImage: "arrow.right.circle.fill")
					}
				}
				
				VStack(alignment: .leading) {
					Text("Answers")
						.font(.system(.subheadline, design: .rounded, weight: .bold))
						.foregroundStyle(.secondary)
					
					ScrollView(.horizontal) {
						HStack {
							ForEach(multipleChoice.answers, id: \.self) { answer in
								Text(answer)
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
