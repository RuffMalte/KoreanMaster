//
//  ModifyLessonGoalExampleListCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 16.03.24.
//

import SwiftUI

struct ModifyLessonGoalExampleListCellView: View {
	
	@State var lessonGoalExample: LessonGoalExample
	var removeFuntion: () -> Void

	
    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				TextField("Title", text: $lessonGoalExample.title)
				TextField("Translated Text", text: $lessonGoalExample.translatedText)
				
				HStack {
					TextField("Korean Text", text: $lessonGoalExample.koreanText)
					Button {
						TranslationController().getTranslation(for: lessonGoalExample.translatedText, targetLang: "KO") { result, error in
							guard error != nil else {
								if let result = result {
									lessonGoalExample.koreanText = result
									return
								}
								return
							}
						}
					} label: {
						Label("Translate", systemImage: "arrow.right.arrow.left")
					}
				}
			}
			
			Spacer()
			
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
	ModifyLessonGoalExampleListCellView(lessonGoalExample: LessonGoalExample.mutlipleExample[0], removeFuntion: {print("remove")})
}
