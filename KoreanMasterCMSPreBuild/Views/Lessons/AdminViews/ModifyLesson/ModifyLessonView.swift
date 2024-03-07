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
	
	
    var body: some View {
		Form {
			
			List {
				HStack {
					TextField("Section", value: $lesson.lessonInfo.section, format: .number)
					TextField("Unit", value: $lesson.lessonInfo.unit, format: .number)
				}
				
				TextField("Lesson Name", text: $lesson.lessonInfo.lessonName)
				TextField("Heading", text: $lesson.lessonInfo.heading)
				TextField("Description", text: $lesson.lessonInfo.desc)
				
				
				
			}
		}
		.textFieldStyle(.roundedBorder)
		.navigationTitle(lesson.lessonInfo.lessonName)		
		
	}
			
			
			
			
			
}

#Preview {
	ModifyLessonView(lesson: Lesson.detailExample)
}
