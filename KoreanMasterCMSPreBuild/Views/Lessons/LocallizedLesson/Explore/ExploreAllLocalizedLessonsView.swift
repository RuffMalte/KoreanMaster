//
//  ExploreAllLocalizedLessonsView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 23.03.24.
//

//TODO: Implement section and unit sorting With new Views
//admin controls
//tag sorting
//search


import SwiftUI

struct ExploreAllLocalizedLessonsView: View {
	
	var lessons: [Lesson]
	var currentLanguage: String
	var completedLessonIDs: [String] = []
	
	var completeFunc: ((Lesson) -> Void)?
	
	@State var selectedLesson: Lesson?
	@State private var isShowingLesson = false
	
	@State private var scrollToLessonId: String?
	
	private var nextLessonToCompleteIndex: Int {
		let completedIndexes = lessons.enumerated().filter { completedLessonIDs.contains($0.element.id) }.map(\.offset)
		let maxCompletedIndex = completedIndexes.max() ?? -1
		return maxCompletedIndex + 1
	}

    var body: some View {
		HStack {
			Spacer()
			ScrollView(showsIndicators: false) {
				ScrollViewReader { proxy in
					VStack(spacing: 20) {
						ForEach(Array(lessons.enumerated()), id: \.element.id) { index, lesson in
							HStack {
								if index % 4 != 0 {
									Spacer()
								}
								
								
								let isCompleted = completedLessonIDs.contains(lesson.id)
								ExploreLessonCellView(lesson: lesson, isCompleted: isCompleted, complition: { lesson in
									self.selectedLesson = lesson
									isShowingLesson.toggle()
								})
								.id(lesson.id)
								.disabled(index > nextLessonToCompleteIndex)

								
								if index % 4 != 2 {
									Spacer()
								}
							}

						}
					}
					.onChange(of: scrollToLessonId, { oldValue, newValue in
						withAnimation {
							proxy.scrollTo(newValue, anchor: .top)
							scrollToLessonId = nil
							scrollToLessonId = nil
						}
					})
				}
				.padding()
			}
			.frame(width: 250)
			Spacer()
		}
		.overlay {
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button {
						withAnimation {
							scrollToLessonId = lessons.first?.id
							//TODO: add logic to skip to next lesson
						}
					} label: {
						Image(systemName: "arrow.up")
					}
					.buttonStyle(.borderedProminent)
					.padding()
				}
			}
		}
		.onChange(of: selectedLesson?.id, { oldValue, newValue in
			if newValue != nil {
				isShowingLesson = true
				print("LessonID: \(newValue!)")
			}
		})
		.sheet(isPresented: $isShowingLesson) {
			if let selectedLesson = selectedLesson {
				InSessionLessonMainView(lesson: selectedLesson, currentLanguage: currentLanguage) {
					isShowingLesson = false
					completeFunc?(selectedLesson)
				}
				.presentationCompactAdaptation(.fullScreenCover)
			}
		}

	}
}





