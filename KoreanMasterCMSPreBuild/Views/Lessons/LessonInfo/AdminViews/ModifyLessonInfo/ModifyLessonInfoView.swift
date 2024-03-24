//
//  ModifyLessonInfoView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct ModifyLessonInfoView: View {
	
	@State var lessonInfo: LessonInfo
	var language: String
	
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
				
				TextField("XP to gain", value: $lessonInfo.xpToGain, format: .number)
				
				
				HStack {
					MaltesSFIconPicker(selectedIcon: $lessonInfo.icon, displayStyle: .medium)
					Spacer()
					MaltesColorPicker(color: $lessonInfo.color, colorPickerStyle: .menu)
				}
				.padding(8)
				.background {
					RoundedRectangle(cornerRadius: 8)
						.foregroundStyle(Color.background)
				}
				
				LessonDifficultyPickerView(selectedDifficultyID: $lessonInfo.difficultyID, language: language)
				
			}
		} header: {
			Text("Lesson Info")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
    }
}

#Preview {
	ModifyLessonInfoView(lessonInfo: LessonInfo.detailExample, language: "English")
}
