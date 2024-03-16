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
		Section {
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
		} header: {
			Text("Lesson Info")
				.font(.system(.title2, design: .rounded, weight: .bold))
		}
    }
}

#Preview {
	ModifyLessonInfoView(lessonInfo: LessonInfo.detailExample)
}
