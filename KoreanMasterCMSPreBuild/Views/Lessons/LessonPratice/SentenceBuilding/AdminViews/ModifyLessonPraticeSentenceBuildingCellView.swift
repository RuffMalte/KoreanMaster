//
//  ModifyLessonPraticeSentenceBuildingCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 19.03.24.
//

import SwiftUI

struct ModifyLessonPraticeSentenceBuildingCellView: View {
	
	@State var lessonPraticeSentenceBuilding: LessonpracticeSentenceBuilding
	var removeFuntion: () -> Void
	
    var body: some View {
		HStack {
			VStack {
				TextField("Question", text: $lessonPraticeSentenceBuilding.question)
				TextField("Answer", text: $lessonPraticeSentenceBuilding.correctAnswer)
			}
			Button {
				removeFuntion()
			} label: {
				Image(systemName: "xmark")
			}
		}
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	ModifyLessonPraticeSentenceBuildingCellView(lessonPraticeSentenceBuilding: LessonpracticeSentenceBuilding.multipleExample[0], removeFuntion: { print("Remove") })
}
