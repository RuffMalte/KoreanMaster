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
	
	
    var body: some View {
		InSessionLessonHeaderView(title: pratice.title, subtitle: pratice.desc) {
			VStack {
				switch currentPraticeMode {
				case .multipleChoice:
					InSessionLessonPageinatedItemsView(
						items: pratice.mulitpleChoice ?? [],
						onEnd: isAbleToSwitchLesson ? switchPraticeMode : {}
					) { mp in
						InSessionLessonMultipleChoiceItemView(multipleChoice: mp)
					}
					
				case .sentenceBuilding:
					InSessionLessonPageinatedItemsView(
						items: pratice.sentenceBuilding ?? [],
						onEnd: isAbleToSwitchLesson ? switchPraticeMode : {}
					) { sb in
						Text(sb.question)
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
