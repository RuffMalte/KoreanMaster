//
//  ModifyLessonInfoView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct ModifyLessonInfoView: View {
	
	@State var lessonInfo: LessonInfo
	
    var body: some View {
		Form {
			VStack(alignment: .leading) {
				HStack {
					TextField("Section", value: $lessonInfo.section, format: .number)
					TextField("Unit", value: $lessonInfo.unit, format: .number)
				}
				
				TextField("Lesson Name", text: $lessonInfo.lessonName)
				TextField("Heading", text: $lessonInfo.heading)
				TextField("Description", text: $lessonInfo.desc)
				//TODO: comments and likes
			}
		}
    }
}

#Preview {
	ModifyLessonInfoView(lessonInfo: LessonInfo.detailExample)
}
