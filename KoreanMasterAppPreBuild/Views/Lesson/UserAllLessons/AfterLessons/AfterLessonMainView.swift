//
//  AfterLessonMainView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 07.04.24.
//

import SwiftUI

struct AfterLessonMainView: View {
	
	var afterLesson: AfterLessonModel
	var onEnd: () -> Void
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		VStack {
			if afterLesson.hasNewStreakItem {
				AfterLessonStreakExtensionView(afterLesson: afterLesson) {
					onEnd()
				}
				
				
			} else {
				AfterLessonSummaryView(afterLesson: afterLesson) {
					onEnd()
				}
				
				
			}
		}
    }
}

#Preview {
	AfterLessonMainView(afterLesson: AfterLessonModel(lesson: Lesson.detailExample, user: FirestoreUser.singleExample, hasNewStreakItem: true), onEnd: {})
}

struct AfterLessonModel: Identifiable {
	var id = UUID()
	
	var lesson: Lesson
	var user: FirestoreUser
	var hasNewStreakItem: Bool
}
