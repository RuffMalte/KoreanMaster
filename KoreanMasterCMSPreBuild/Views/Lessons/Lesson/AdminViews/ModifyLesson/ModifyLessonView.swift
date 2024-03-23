//
//  ModifyLessonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

///if the optional is not set it will create a new lesson
struct ModifyLessonView: View {
	
	@State var lesson: Lesson?
	@State var currentLanguage: String
	@EnvironmentObject var courseCon: CoursesController

	
    var body: some View {
		VStack {
			if courseCon.isLoadingSingleLesson {
				ProgressView()
			} else if let curLesson = lesson {
				GeometryReader { reader in
					HStack {
						ScrollView(.vertical) {
							VStack(alignment: .leading) {
								ModifyLessonInfoView(lessonInfo: curLesson.lessonInfo, language: currentLanguage)
								
								Divider()
								
								ModifyLessonTagsView(lessonTag: curLesson.lessonTag)
								
								Divider()
								
								if let lessonGoal = curLesson.lessonGoal {
									ModifyLessonGoalView(lessonGoal: lessonGoal)
								}
								
								Divider()
								
								if let vocabUsed = curLesson.newLessonVocabUsed {
									ModifyVLessonVocabUsedView(vocabUsed: vocabUsed, language: currentLanguage)
								}
								Divider()
								
								if let lessonGrammar = curLesson.lessonGrammar {
									ModifyLessonGrammarView(lessonGrammar: lessonGrammar, language: currentLanguage)
								}
								
								Divider()
								
								if let lessonPractice = curLesson.lessonPractice {
									ModifyLessonPraticeView(lessonPractice: lessonPractice, language: currentLanguage)
								}
								
								Divider()
								
								if let lessonCultureReferences = curLesson.lessonCultureReferences {
									ModifyLessonCultureRefrence(lessonCultureRefrence: lessonCultureReferences)
								}
								
								Spacer()
							}
							.padding()
						}
						.frame(width: reader.size.width / 2, height: reader.size.height, alignment: .center)
						
						
						InSessionLessonMainView(lesson: curLesson, currentLanguage: currentLanguage)
							.frame(width: reader.size.width / 2, height: reader.size.height, alignment: .center)
					}
				}
				
			}
		}
		.onAppear {
			if let lesson = lesson {
				courseCon.getFullLesson(lessonName: lesson.lessonInfo.lessonName, language: currentLanguage) { Lesson, error in
					if let Lesson = Lesson {
						self.lesson = Lesson
					}
				}
			} else {
				let newLesson = Lesson.new
				newLesson.id = UUID().uuidString
				self.lesson = newLesson
			}
			
		}
		.textFieldStyle(.roundedBorder)
		.navigationTitle(lesson?.lessonInfo.lessonName ?? "New Lesson")
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				if let lesson = lesson {
					NavigationLink {
						JSONView(model: lesson)
					} label: {
						Label("JSON", systemImage: "ellipsis.curlybraces")
					}
				}
			}
			ToolbarItem(placement: .primaryAction) {
				Button {
					if let lesson = lesson {
						courseCon.SaveLesson(lesson: lesson, language: currentLanguage) { bool in
							if bool {
								print("Lesson added")
							} else {
								print("Lesson not added")
							}
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
