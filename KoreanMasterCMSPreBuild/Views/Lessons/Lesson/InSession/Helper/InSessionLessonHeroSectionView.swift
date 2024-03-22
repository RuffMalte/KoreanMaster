//
//  InSessionLessonHeroSectionView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonHeroSectionView: View {
	
	@Binding var lesson: Lesson
	var currentLanguage: String
	@Binding var selectedTypeIndex: Int
	@Binding var currentTab: DocumentReferenceGenerator.InSessionLessonType
	@Binding var isShowingDebug: Bool
	var switchToNextSubLesson: () -> Void
	var switchBackToSubLesson: () -> Void
	
	
	@EnvironmentObject var loginCon: LoginController
	
	@StateObject var difficultyCon: DifficultyController = DifficultyController()
	@State private var lessonDifficulty: LessonDiffuculty?
	
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
					if let lessonDifficulty = lessonDifficulty {
						HStack {
							Label {
								Text(lessonDifficulty.difficulty)
							} icon: {
								Image(systemName: lessonDifficulty.SFicon)
							}
							.foregroundStyle(lessonDifficulty.color.toColor)
							
							Text(" - ")
						}
					}
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
			
		}
		.onAppear {
			getDiff()
		}
		.onChange(of: lesson.lessonInfo.difficultyID) { oldValue, newValue in
			getDiff()
		}
    }
	
	func getDiff() {
		difficultyCon.getDifficulties(with: [lesson.lessonInfo.difficultyID], language: currentLanguage) { diffs, error in
			if error == nil && diffs.count > 0 && diffs.count < 2 {
				lessonDifficulty = diffs[0]
			}
		}
	}
}
