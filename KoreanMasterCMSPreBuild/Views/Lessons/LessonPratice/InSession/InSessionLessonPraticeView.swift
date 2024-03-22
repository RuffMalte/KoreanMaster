//
//  InSessionLessonPraticeView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonPraticeView: View {
	
	@State var pratice: LessonPractice
	var switchLesson: () -> Void
	
	@State var currentPraticeMode: DocumentReferenceGenerator.PraticeType = .multipleChoice
	var isAbleToSwitchLesson: Bool = true
	
	@State var showNavigationButtons = false
	@State var hasAnswerBeenSelected: Bool = false

	
    var body: some View {
		InSessionLessonHeaderView(title: pratice.title, subtitle: pratice.desc) {
			VStack {
				switch currentPraticeMode {
				case .multipleChoice:
					InSessionLessonPageinatedItemsView(
						items: pratice.mulitpleChoice ?? [],
						showNavigationButtons: $showNavigationButtons,
						hasAnswerBeenSelected: $hasAnswerBeenSelected,
						onEnd: isAbleToSwitchLesson ? switchPraticeMode : {}
					) { mp in
						InSessionLessonMultipleChoiceItemView(
							multipleChoice: mp,
							showNavigationButtons: $showNavigationButtons,
							hasAnswerBeenSelected: $hasAnswerBeenSelected
						)
					}
					
				case .sentenceBuilding:
					InSessionLessonPageinatedItemsView(
						items: pratice.sentenceBuilding ?? [],
						showNavigationButtons: $showNavigationButtons,
						hasAnswerBeenSelected: $hasAnswerBeenSelected,
						onEnd: isAbleToSwitchLesson ? switchLesson : {}
					) { sb in
						InSessionLessonPraticeSentenceBuildingItemView(
							sentenceB: sb,
							showNavigationButtons: $showNavigationButtons,
							hasAnswerBeenSelected: $hasAnswerBeenSelected
						)
						.onAppear {
							showNavigationButtons = false
							hasAnswerBeenSelected = false
						}
					}
					
				}
			}
		}
    }
	
	func switchPraticeMode() {
		switch currentPraticeMode {
		case .multipleChoice:
			currentPraticeMode = .sentenceBuilding
		case .sentenceBuilding:
			currentPraticeMode = .multipleChoice
		}
	}
}
