//
//  ModifyMultipleChoiceAnswerView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 17.03.24.
//

import SwiftUI

struct ModifyMultipleChoiceAnswerView: View {
	
	@State var answer: LessonPraticeMultipleChoiceAnswer
	var deletionAction: () -> Void
	var changeCorrectAction: () -> Void
	
	@FocusState private var isFocused: Bool
	
    var body: some View {
		HStack {
			TextField("Answer", text: $answer.answer)
				.focused($isFocused)
			
			if isFocused {
				Button {
					deletionAction()
				} label: {
					Image(systemName: "xmark.circle.fill")
						.foregroundStyle(.secondary)
				}
				.buttonStyle(.plain)
				
				Button {
					changeCorrectAction()
				} label: {
					Image(systemName: "checkmark.circle.fill")
				}
			}
		}
		.overlay {
			if answer.isCorret {
				RoundedRectangle(cornerRadius: 4)
					.stroke(.green, lineWidth: 2)
			}
		}
		.padding(4)
    }
}

#Preview {
	ModifyMultipleChoiceAnswerView(answer: LessonPraticeMultipleChoiceAnswer.example, deletionAction: { print("Delete") }, changeCorrectAction: {print("Change")})
}
