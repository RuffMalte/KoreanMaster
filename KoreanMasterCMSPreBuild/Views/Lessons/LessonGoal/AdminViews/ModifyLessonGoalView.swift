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
		Section {
			TextField("title", text: $lessonGoal.title)
			TextField("Goal text", text: $lessonGoal.goalText)
			
			NavigationLink {
				List {
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
				HStack {
					Label("Examples", systemImage: "text.book.closed.fill")
					Spacer()
					Label(lessonGoal.lessonGoalExamples?.count.description ?? "Unknown", systemImage: "number")
						.font(.system(.headline, design: .monospaced, weight: .regular))
					
					Image(systemName: "chevron.right")
				}
				.font(.system(.headline, design: .rounded, weight: .bold))
			}

		} header: {
			Text("Lesson Goal")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
	}
	
}

#Preview {
	ModifyLessonGoalView(lessonGoal: LessonGoal.example)
}
