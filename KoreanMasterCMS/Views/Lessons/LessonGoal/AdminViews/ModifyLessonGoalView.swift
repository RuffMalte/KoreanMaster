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
				GeometryReader { geo in
					HStack {
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
						.frame(width: geo.size.width / 2, height: geo.size.height)
						
						InSessionLessonGoalView(lessonGoal: lessonGoal) {}
							.padding()
							.frame(width: geo.size.width / 2, height: geo.size.height)
					}
					.navigationTitle("Lesson Goal Examples")
				}
			} label: {
				NavLinkHeaderView(headerText: "Examples", headerSFIcon: "text.book.closed.fill", count: lessonGoal.lessonGoalExamples?.count ?? 999)
			}

		} header: {
			Text("Lesson Goal")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
		.navigationTitle("Lesson Goal")
	}
	
}

#Preview {
	ModifyLessonGoalView(lessonGoal: LessonGoal.example)
}
