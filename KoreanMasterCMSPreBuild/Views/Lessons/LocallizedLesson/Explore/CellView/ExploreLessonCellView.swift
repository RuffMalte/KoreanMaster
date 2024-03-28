//
//  ExploreLessonCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

struct ExploreLessonCellView: View {
	
	var lesson: Lesson
	var isButtonDisabled: Bool = false
	var isCompleted: Bool = false
	
	var complition: (Lesson) -> Void
	
	@State private var showDetail = false
	
    var body: some View {
		Button {
			showDetail.toggle()
		} label: {
			VStack {
				ZStack {
					CheckmarkCircle(isChecked: isCompleted, mainColor: lesson.lessonInfo.color.toColor)
					Image(systemName: lesson.lessonInfo.icon)
						.foregroundColor(lesson.lessonInfo.color.toColor)
						.font(.system(.title2, weight: .bold))
				}
				.frame(width: 80, height: 80)

				Text(lesson.lessonInfo.lessonName)
					.font(.system(.headline, design: .rounded, weight: .bold))
					.lineLimit(1)
			}
		}
		.buttonStyle(.plain)
		.popover(isPresented: $showDetail, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
			ZStack {
				lesson.lessonInfo.color.toColor
					.opacity(0.3)
					//https://stackoverflow.com/questions/61733224/swiftui-popover-background-color
					.scaleEffect(2.5)
				
				VStack(alignment: .leading, spacing: 10) {
					VStack(alignment: .leading) {
						Text(lesson.lessonInfo.getSectionUnit())
							.font(.system(.subheadline, design: .monospaced, weight: .bold))
							.lineLimit(1)
						
						Text(lesson.lessonInfo.heading)
							.font(.system(.footnote, design: .rounded, weight: .regular))
							.lineLimit(2)
						
					}
					
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							ForEach(lesson.lessonTag.lessonTagItems ?? []) { tag in
								LessonTagSmallView(lessonTag: tag)
							}
						}
					}
					
					VStack {
						ExploreLessonStartButtonView(
							isButtonDisabled: isButtonDisabled,
							startLessonFunction: {
								complition(lesson)
							},
							xpToGain: lesson.lessonInfo.xpToGain
						)
						.buttonStyle(.plain)
					}
				}
			}
			.presentationCompactAdaptation(.popover)
			.frame(width: 150)
			.padding()
		}
    }
}

struct CheckmarkCircle: View {
	var isChecked: Bool
	var mainColor: Color = .purple
	
	var body: some View {
		Circle()
			.foregroundStyle(mainColor.opacity(0.3))
			.padding(9)
			.overlay {
				Circle()
					.strokeBorder(isChecked ? Color.yellow : Color.secondary, lineWidth: 4)
					.overlay {
						VStack {
							Spacer()
							HStack {
								Spacer()
								Image(systemName: "checkmark.seal.fill")
									.foregroundColor(isChecked ? .yellow : .secondary)
									.font(.system(.title3, design: .rounded, weight: .black))
									.padding(1)
									.background {
										Circle().foregroundColor(Color.tertiaryBackground)
									}
							}
						}
					}
			}
	}
}


#Preview {
	ExploreLessonCellView(lesson: Lesson.detailExample) { string in
		print("Start lesson: \(string)")
	}
}
