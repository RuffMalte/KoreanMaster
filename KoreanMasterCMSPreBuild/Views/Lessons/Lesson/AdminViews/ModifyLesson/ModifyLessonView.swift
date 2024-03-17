//
//  ModifyLessonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

///if the optional is not set it will create a new lesson
struct ModifyLessonView: View {
	
	@State var lesson: Lesson
	@State var currentLanguage: String
	@EnvironmentObject var courseCon: CoursesController

	
    var body: some View {
		Form {
			if courseCon.isLoadingSingleLesson {
				ProgressView()
			} else {
				GeometryReader { reader in
					HStack {
						ScrollView(.vertical) {
							VStack(alignment: .leading) {
								ModifyLessonInfoView(lessonInfo: lesson.lessonInfo)
								
								Divider()
								
								ModifyLessonTagsView(lessonTag: lesson.lessonTag)
								
								Divider()
								
								if let lessonGoal = lesson.lessonGoal {
									ModifyLessonGoalView(lessonGoal: lessonGoal)
								}
								
								Divider()
								
								if let vocabUsed = lesson.newLessonVocabUsed {
									ModifyVLessonVocabUsedView(vocabUsed: vocabUsed, language: currentLanguage)
								}
								Divider()
								
								if let lessonGrammar = lesson.lessonGrammar {
									ModifyLessonGrammarView(lessonGrammar: lessonGrammar, language: currentLanguage)
								}
								
								Divider()
								
								if let lessonPractice = lesson.lessonPractice {
									ModifyLessonPraticeView(lessonPractice: lessonPractice, language: currentLanguage)
								}
								
								
								Spacer()
							}
							.padding()
						}
						.frame(width: reader.size.width / 2, height: reader.size.height, alignment: .center)
						
						
						Text("Lesson Preview")
							.frame(width: reader.size.width / 2, height: reader.size.height, alignment: .center)
					}
				}
				
			}
		}
		.onAppear {
			courseCon.getFullLesson(lessonName: lesson.lessonInfo.lessonName, language: currentLanguage) { Lesson, error in
				if let Lesson = Lesson {
					self.lesson = Lesson
				}
			}
		}
		.textFieldStyle(.roundedBorder)
		.navigationTitle(lesson.lessonInfo.lessonName)		
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				NavigationLink {
					JSONView(model: lesson)
				} label: {
					Label("JSON", systemImage: "ellipsis.curlybraces")
				}
			}
			ToolbarItem(placement: .primaryAction) {
				Button {
					courseCon.SaveLesson(lesson: lesson, language: currentLanguage) { bool in
						if bool {
							print("Lesson added")
						} else {
							print("Lesson not added")
						}
					}
				} label: {
					Label("Save", systemImage: "square.and.arrow.down")
				}
			}
		}
	}
			
			
			
			
			
}

#Preview {
	ModifyLessonView(lesson: Lesson.detailExample, currentLanguage: "English")
}
