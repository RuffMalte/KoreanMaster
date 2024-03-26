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
	
	@State var selectedLesson: Lesson?
	@State private var isShowingLesson = false
	
	@State private var scrollToLessonId: String? // ID of the lesson to scroll to

    var body: some View {
		HStack {
			Spacer()
			ScrollView {
				ScrollViewReader { proxy in
					VStack(spacing: 20) {
						ForEach(Array(lessons.enumerated()), id: \.element.id) { index, lesson in
							HStack {
								if index % 4 == 0 {
									// Left aligned
									ExploreLessonCellView(lesson: lesson, complition: { lesson in
										self.selectedLesson = lesson
										isShowingLesson.toggle()
										
									})
									.id(lesson.lessonInfo.lessonName)
									Spacer()
								} else if index % 4 == 1 || index % 4 == 3 {
									// Middle aligned
									Spacer()
									ExploreLessonCellView(lesson: lesson, complition: { lesson in
										self.selectedLesson = lesson
										isShowingLesson.toggle()
										
									})
									.id(lesson.lessonInfo.lessonName)
									Spacer()
								} else if index % 4 == 2 {
									// Right aligned
									Spacer()
									ExploreLessonCellView(lesson: lesson, complition: { lesson in
										self.selectedLesson = lesson
										isShowingLesson.toggle()
										
									})
									.id(lesson.lessonInfo.lessonName)
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
			.overlay {
				VStack {
					Spacer()
					HStack {
						Spacer()
						Button {
							withAnimation {
								scrollToLessonId = lessons.first?.lessonInfo.lessonName
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
			.frame(width: 250)
			
			Spacer()
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
				}
			}
		}
		.background {
			Color.tertiaryBackground
				.ignoresSafeArea()
		}
	}
}





