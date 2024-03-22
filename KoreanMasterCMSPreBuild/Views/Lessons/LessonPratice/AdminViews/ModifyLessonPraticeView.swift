//
//  ModifyLessonPraticeView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 17.03.24.
//

import SwiftUI

struct ModifyLessonPraticeView: View {
	
	@State var lessonPractice: LessonPractice
	var language: String
	
    var body: some View {
		Section {
			TextField("Title", text: $lessonPractice.title)
			TextField("Desc", text: $lessonPractice.desc)
		
			
			HStack {
				NavigationLink {
					GeometryReader { geo in
						HStack {
							List {
								Button {
									lessonPractice.mulitpleChoice?.append(LessonpracticeMultipleChoice.empty)
								} label: {
									Label("Add new Multiplechoice Question", systemImage: "plus")
								}
								
								ForEach(lessonPractice.mulitpleChoice ?? []) { mp in
									ModifyLessonPraticeMultipleChoiceCellView(multipleChoice: mp, removeFuntion: {
										lessonPractice.mulitpleChoice?.removeAll(where: { $0.id == mp.id })
									})
									.padding(.vertical, 5)
								}
							}
							.frame(width: geo.size.width / 2, height: geo.size.height)
							
							InSessionLessonPraticeView(
								pratice: lessonPractice,
								switchLesson: {},
								currentPraticeMode: .multipleChoice,
								isAbleToSwitchLesson: false
							)
							.padding()
							.frame(width: geo.size.width / 2, height: geo.size.height)

							
						}
					}
				} label: {
					NavLinkHeaderView(headerText: "Multiple Choice", headerSFIcon: "shippingbox.and.arrow.backward.fill", count: lessonPractice.mulitpleChoice?.count ?? 999)
				}

				NavigationLink {
					GeometryReader { geo in
						HStack {
							List {
								Button {
									lessonPractice.sentenceBuilding?.append(LessonpracticeSentenceBuilding.empty)
								} label: {
									Label("Add new Sentence Building Question", systemImage: "plus")
									
								}
								
								ForEach(lessonPractice.sentenceBuilding ?? []) { sb in
									ModifyLessonPraticeSentenceBuildingCellView(lessonPraticeSentenceBuilding: sb, removeFuntion: {
										lessonPractice.sentenceBuilding?.removeAll(where: { $0.id == sb.id })
									})
									.padding(.vertical, 5)
								}
							}
							
							InSessionLessonPraticeView(
								pratice: lessonPractice,
								switchLesson: {},
								currentPraticeMode: .sentenceBuilding,
								isAbleToSwitchLesson: false
							)
							.padding()
							.frame(width: geo.size.width / 2, height: geo.size.height)
						}
					}
				} label: {
					NavLinkHeaderView(headerText: "Sentence Building", headerSFIcon: "slider.horizontal.2.rectangle.and.arrow.triangle.2.circlepath", count: lessonPractice.sentenceBuilding?.count ?? 999)
				}
			}
		} header: {
			Text("Pratice for this Lesson")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	ModifyLessonPraticeView(lessonPractice: LessonPractice.example, language: "English")
}
