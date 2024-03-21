//
//  InSessionLessonMainView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonMainView: View {
	
	@State var lesson: Lesson
	
	
	@State private var currentTab: DocumentReferenceGenerator.InSessionLessonType = .info
	@State private var selectedTypeIndex = 0

	@State private var isShowingDebug = false
	@EnvironmentObject var loginCon: LoginController

    var body: some View {
		VStack {
			if ((loginCon.currentFirestoreUser?.isAdminLesson) != nil) {
				VStack {
					Text("Admin Controls")
						.font(.system(.headline, design: .rounded, weight: .bold))
						.foregroundStyle(.tint)
					HStack {
						Spacer()
						Toggle("Degbug Mode", isOn: $isShowingDebug)
						InSessionSwitchBackToSubLessonButtonView(switchLesson: switchBackToSubLesson)
						InSessionSwitchSubLessonButtonView(switchLesson: switchToNextSubLesson)
						Spacer()
					}
				}
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 10)
						.foregroundStyle(.bar)
				}
			}
			
			HStack {
				ScrollView(.horizontal) {
					HStack {
						ForEach(lesson.lessonTag.lessonTagItems ?? []) { tag in
							LessonTagSmallView(lessonTag: tag)
						}
					}
				}
				Spacer()
				LessonLikeSmallNavButtonView(likedBy: lesson.lessonInfo.likedBy ?? [])
				LessonCommentSmallNavButtonView(commentedBy: lesson.lessonInfo.commentedBy ?? [])
			}
			
			
			HStack {
				Text(lesson.lessonInfo.lessonName)
				Spacer()
				HStack {
					Text(lesson.lessonInfo.difficulty)
					Text(" - ")
					Text(lesson.lessonInfo.xpToGain.description)
				}
			}
			.font(.system(.headline, design: .rounded, weight: .bold))
			
			
			Gauge(value: CGFloat(selectedTypeIndex + 1) / CGFloat(DocumentReferenceGenerator.InSessionLessonType.allCases.count)) {
				Text("Progress")
			}
			.gaugeStyle(.accessoryLinear)
		
			if ((loginCon.currentFirestoreUser?.isAdminLesson) != nil && isShowingDebug) {
				HStack {
					ForEach(DocumentReferenceGenerator.InSessionLessonType.allCases.indices, id: \.self) { index in
						Text(DocumentReferenceGenerator.InSessionLessonType.allCases[index].rawValue)
							.padding()
							.background(self.selectedTypeIndex >= index ? Color.green : Color.gray)
							.cornerRadius(4)
							.onTapGesture {
								withAnimation {
									self.selectedTypeIndex = index
									currentTab = DocumentReferenceGenerator.InSessionLessonType.allCases[index]
								}
							}
					}
				}
			}
			
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
						Text("vocabUsed")
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
	InSessionLessonMainView(lesson: Lesson.detailExample)
}
