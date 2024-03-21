//
//  ModifyDificultySheetView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct ModifyDificultySheetView: View {
	
	@State var lessonDifficulty: LessonDiffuculty
	@State var language: String
	
	@StateObject var difficultyCon: DifficultyController
	
	@Environment(\.dismiss) var dismiss

	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Difficulty String", text: $lessonDifficulty.difficulty)
					MaltesColorPicker(color: $lessonDifficulty.color, colorPickerStyle: .menu)
						.tint(lessonDifficulty.color.toColor)
					//TODO: Add Icon Picker
					Label {
						TextField("Icon", text: $lessonDifficulty.SFicon)
					} icon: {
						Image(systemName: lessonDifficulty.SFicon)
					}
				}
			}
			.textFieldStyle(.roundedBorder)
			.padding()
			.navigationTitle("Add new message")
			.toolbar {
				ToolbarItem(placement: .automatic) {
					Button {
						difficultyCon.saveDiffuculty(difficulty: lessonDifficulty, language: language) { bool, error in
							print("Difficulty saved")
						}
						dismiss()
						
					} label: {
						Label("Save", systemImage: "checkmark")
					}
				}
				ToolbarItem(placement: .automatic) {
					Button {
						dismiss()
					} label: {
						Label("Cancel", systemImage: "xmark")
					}
				}
			}
		}
    }
}

#Preview {
	ModifyDificultySheetView(lessonDifficulty: LessonDiffuculty.example, language: "English", difficultyCon: DifficultyController())
}
