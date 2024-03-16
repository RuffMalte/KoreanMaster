//
//  ModifyLessonGoalView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 16.03.24.
//

import SwiftUI

struct ModifyLessonGoalView: View {
	
	@State var lessonGoal: LessonGoal
	
	@State private var isLoading: Bool = false
	
    var body: some View {
		Form {
			Section(header: Text("Lesson Goal")) {
				TextField("title", text: $lessonGoal.title)
				TextField("Goal text", text: $lessonGoal.goalText)
				
				DisclosureGroup {
					VStack(alignment: .leading) {
						Button {
							lessonGoal.lessonGoalExamples?.append(LessonGoalExample.empty)
						} label: {
							Label("Add Example", systemImage: "plus")
						}
						
						
						ForEach(lessonGoal.lessonGoalExamples ?? []) { example in
							ModifyLessonGoalExampleListCellView(lessonGoalExample: example, removeFuntion: {
								lessonGoal.lessonGoalExamples?.removeAll(where: { $0.id == example.id })
							})
							.padding(.vertical, 5)
						}
					}
				} label: {
					Label("Examples", systemImage: "list.bullet")
				}

			}
		}
	}
}

#Preview {
	ModifyLessonGoalView(lessonGoal: LessonGoal.example)
}
