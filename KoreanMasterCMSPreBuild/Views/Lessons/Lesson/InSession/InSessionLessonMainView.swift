//
//  InSessionLessonMainView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonMainView: View {
	
	@State var lesson: Lesson
	var currentLanguage: String
	
	@State private var currentTab: DocumentReferenceGenerator.InSessionLessonType = .info
	@State private var selectedTypeIndex = 0

	@State private var isShowingDebug = false
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
		VStack {
			InSessionLessonHeroSectionView(
				lesson: $lesson,
				currentLanguage: currentLanguage,
				selectedTypeIndex: $selectedTypeIndex,
				currentTab: $currentTab,
				isShowingDebug: $isShowingDebug,
				switchToNextSubLesson: switchToNextSubLesson,
				switchBackToSubLesson: switchBackToSubLesson
			)
			
			HStack {
				Spacer()
				VStack {
					Spacer()
					
					switch currentTab {
					case .info:
						InSessionLessonInfoView(lessonInfo: lesson.lessonInfo, switchLesson: switchToNextSubLesson)
					case .goal:
						if let lessonGoal = lesson.lessonGoal {
							InSessionLessonGoalView(lessonGoal: lessonGoal, switchLesson: switchToNextSubLesson)
						}
					case .vocabUsed:
						if let vocabUsed = lesson.newLessonVocabUsed {
							InSessionLessonVocabUsedView(vocab: vocabUsed, currentLanguage: currentLanguage, switchLesson: switchToNextSubLesson)
						}
					case .grammar:
						Text("grammar")
					case .practice:
						Text("Ipracticenfo")
					case .cultureReferences:
						Text("cultureReferences")
					}
					Spacer()
					
				}
				Spacer()
			}
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 20)
					.foregroundStyle(.secondary.opacity(0.2))
			}
			.overlay {
				VStack {
					Spacer()
					HStack {
						Spacer()
						InSessionSwitchBackToSubLessonButtonView(switchLesson: switchBackToSubLesson)
							.padding()
					}
				}
			}
			
		}
		.padding()
    }
	
	private func switchToNextSubLesson() {
		let allCases = DocumentReferenceGenerator.InSessionLessonType.allCases
		let currentIndex = allCases.firstIndex(of: currentTab) ?? 0
		let nextIndex = currentIndex + 1
		
		if nextIndex < allCases.count {
			withAnimation {
				selectedTypeIndex = nextIndex
				currentTab = allCases[nextIndex]
			}
		}
	}
	private func switchBackToSubLesson() {
		let allCases = DocumentReferenceGenerator.InSessionLessonType.allCases
		let currentIndex = allCases.firstIndex(of: currentTab) ?? 0
		let nextIndex = currentIndex - 1
		
		if nextIndex >= 0 {
			withAnimation {
				selectedTypeIndex = nextIndex
				currentTab = allCases[nextIndex]
			}
		}
	}
}

#Preview {
	InSessionLessonMainView(lesson: Lesson.detailExample, currentLanguage: "English")
}
