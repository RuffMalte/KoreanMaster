//
//  ExploreLessonCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

struct ExploreLessonCellView: View {
	
	var lesson: Lesson
	
	var complition: (Lesson) -> Void
	
	@State private var showDetail = false
	
    var body: some View {
		Button {
			showDetail.toggle()
		} label: {
			VStack {
				ZStack {
					CheckmarkCircle(isChecked: true, mainColor: .purple)
					Image(systemName: "book")
						.foregroundColor(.purple)
						.font(.system(.title, weight: .bold))
				}
				Text(lesson.lessonInfo.lessonName)
					.font(.system(.title3, design: .rounded, weight: .bold))
			}
		}
		.buttonStyle(.plain)
		.popover(isPresented: $showDetail, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
			ZStack {
				Color.purple
					.opacity(0.5)
					//https://stackoverflow.com/questions/61733224/swiftui-popover-background-color
					.scaleEffect(2.5)
				
				VStack(alignment: .leading, spacing: 10) {
					VStack(alignment: .leading) {
						Text(lesson.lessonInfo.getSectionUnit())
							.font(.system(.headline, design: .monospaced, weight: .bold))
							.lineLimit(1)
						
						Text(lesson.lessonInfo.heading)
							.font(.system(.subheadline, design: .rounded, weight: .regular))
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
							startLessonFunction: {
								complition(lesson)
							},
							xpToGain: lesson.lessonInfo.xpToGain
						)
						.buttonStyle(.plain)
					}
				}
			}
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
			.foregroundStyle(mainColor.opacity(0.5))
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
									.font(.system(.title2, design: .rounded, weight: .black))
									.padding(2)
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
