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
				
				ScrollView(.horizontal) {
					HStack {
						Button {
							lessonPraticeSentenceBuilding.answers.append("new")
						} label: {
							Image(systemName: "plus")
						}
						ForEach(lessonPraticeSentenceBuilding.answers.indices, id: \.self) { index in
							TextField("Answer", text: $lessonPraticeSentenceBuilding.answers[index])
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
		.textFieldStyle(.roundedBorder)
		.navigationTitle("Sentence Building")
    }
}

#Preview {
	ModifyLessonPraticeSentenceBuildingCellView(lessonPraticeSentenceBuilding: LessonpracticeSentenceBuilding.multipleExample[0], removeFuntion: { print("Remove") })
}
