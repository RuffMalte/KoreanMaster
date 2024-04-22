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
	
	@EnvironmentObject var courseCon: CoursesController
	@EnvironmentObject var alertModal: AlertManager
	@State var isLoadingLesson: Bool = false
	
	@State var selectedLesson: Lesson?
	@State private var isShowingLesson = false
	
	@State private var scrollToLessonId: String?
	
	private var nextLessonToCompleteIndex: Int {
		let sortedLessons = lessons.sorted {
			$0.lessonInfo.section < $1.lessonInfo.section ||
			($0.lessonInfo.section == $1.lessonInfo.section && $0.lessonInfo.unit < $1.lessonInfo.unit)
		}
		
		if let index = sortedLessons.firstIndex(where: { !completedLessonIDs.contains($0.id) }) {
			return index
		} else {
			return sortedLessons.count
		}
	}

	
	private var indexedLessons: [(Int, Lesson)] {
		return lessons.enumerated().map { ($0.offset, $0.element) }
	}
	
	private var sortedIndexedLessons: [(Int, Lesson)] {
		return indexedLessons.sorted {
			$0.1.lessonInfo.section < $1.1.lessonInfo.section ||
			($0.1.lessonInfo.section == $1.1.lessonInfo.section && $0.1.lessonInfo.unit < $1.1.lessonInfo.unit)
		}
	}

    var body: some View {
		HStack {
			Spacer()
			ScrollView(showsIndicators: false) {
				ScrollViewReader { proxy in
					VStack(spacing: 20) {
						ForEach(Array(sortedIndexedLessons.enumerated()), id: \.1.1.id) { newIndex, tuple in
							let (index, lesson) = tuple

							HStack {
								if index % 4 != 2 {
									Spacer()
								}
								
								
								let isCompleted = completedLessonIDs.contains(lesson.id)
								ExploreLessonCellView(
									lesson: lesson,
									isButtonDisabled: newIndex > nextLessonToCompleteIndex,
									isCompleted:isCompleted,
									complition: { lesson in
									self.selectedLesson = lesson
									isShowingLesson.toggle()
								})
								.id(lesson.id)
								.onTapGesture {
									scrollToLessonId = lesson.id
								}
								
								if index % 4 != 0 {
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
							scrollToLessonId = completedLessonIDs.last
						}
					} label: {
						Image(systemName: "arrow.down")
					}
					.font(.system(.headline, design: .rounded, weight: .bold))
					.buttonStyle(.borderedProminent)
					.padding()
				}
			}
		}
		.onChange(of: selectedLesson?.id, { oldValue, newValue in
			if newValue != nil {
				isShowingLesson = true
			}
		})
		.withAlertModal(isPresented: $alertModal.isModalPresented)
		.sheet(isPresented: $isShowingLesson) {
			if let selectedLesson = selectedLesson {
				VStack {
					if isLoadingLesson {
						ProgressView()
					} else {
						InSessionLessonMainView(lesson: selectedLesson, currentLanguage: currentLanguage) {
							isShowingLesson = false
							completeFunc?(selectedLesson)
						}
					}
				}
				.presentationCompactAdaptation(.fullScreenCover)
				.onAppear {
					isLoadingLesson = true
					courseCon.getFullLesson(lessonID: selectedLesson.id, language: currentLanguage) { lesson, error in
						if error == nil, let lesson = lesson {
							
							if completedLessonIDs.contains(lesson.id) {
								lesson.lessonInfo.xpToGain = Int(lesson.lessonInfo.xpToGain / 3)
							}
							
							self.selectedLesson = lesson
							isLoadingLesson = false
						} else {
							alertModal.showAlert(.error, heading: "Error", subHeading: "Failed to load lesson")
							isLoadingLesson = false
						}
					}
				}
			}
		}

	}
}





