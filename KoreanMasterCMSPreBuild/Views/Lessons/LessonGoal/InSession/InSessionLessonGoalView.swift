//
//  InSessionLessonGoals.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonGoalView: View {
	
	@State var lessonGoal: LessonGoal
	
	var switchLesson: () -> Void
	
    var body: some View {
		InSessionLessonHeaderView(title: lessonGoal.title, subtitle: lessonGoal.goalText) {
			VStack(spacing: 10) {
				Spacer()
				ForEach(lessonGoal.lessonGoalExamples ?? []) { example in
					InSessionLessonGoalExampleView(example: example)
				}
				
				Spacer()
				
				InSessionSwitchSubLessonButtonView(switchLesson: switchLesson)
				
			}
		}
    }
}

#Preview {
	InSessionLessonGoalView(lessonGoal: LessonGoal.example, switchLesson: { print("switching")})
}
