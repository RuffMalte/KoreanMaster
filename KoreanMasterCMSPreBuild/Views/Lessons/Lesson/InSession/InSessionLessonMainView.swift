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
						if let grammar = lesson.lessonGrammar {
							InSessionLessonGrammarView(grammar: grammar, switchLesson: switchToNextSubLesson)
						}
					case .practice:
						if let practice = lesson.lessonPractice {
							InSessionLessonPraticeView(pratice: practice, switchLesson: switchToNextSubLesson)
						}
					case .cultureReferences:
						if let refrence = lesson.lessonCultureReferences {
							InSessionLessonCultureRefrenceView(culture: refrence, switchLesson: switchToNextSubLesson, endLesson: endLesson)
						}
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
					HStack {
						Spacer()
						InSessionSwitchBackToSubLessonButtonView(switchLesson: switchBackToSubLesson)
							.padding()
					}
					Spacer()
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
	private func endLesson() {
		print("Ending lesson")
	}
}

#Preview {
	InSessionLessonMainView(lesson: Lesson.detailExample, currentLanguage: "English")
}
