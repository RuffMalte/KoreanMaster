//
//  LessonDifficultyPickerView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct LessonDifficultyPickerView: View {
	
	@Binding var selectedDifficultyID: String
	var language: String
	
	@StateObject var diffCon: DifficultyController = DifficultyController()
	
	@State private var allDifficulties: [LessonDiffuculty] = []
	
	@State private var isLoading = false
	@State private var isShowingAddDifficultySheet = false
	var body: some View {
		VStack {
			if isLoading {
				ProgressView()
			} else {
				HStack {
					Picker("Difficulty", selection: $selectedDifficultyID) {
						ForEach(allDifficulties) { diff in
							LessonDifficultyDetailSmallCellView(diff: diff, currentLanguage: language, difficultyCon: diffCon)
								.tag(diff.id)
						}
					}
					Button {
						isShowingAddDifficultySheet.toggle()
					} label: {
						Image(systemName: "plus")
					}
					.buttonStyle(.bordered)
						
					Button {
						getDifficulties(setDiff: false)
					} label: {
						Image(systemName: "arrow.clockwise")
					}
					.buttonStyle(.bordered)
				}
			}
		}
		.onAppear {
			getDifficulties()
		}
		.sheet(isPresented: $isShowingAddDifficultySheet) {
			ModifyDificultySheetView(lessonDifficulty: LessonDiffuculty.new, language: language, difficultyCon: diffCon)
		}
    }
	
	func getDifficulties(setDiff: Bool = true) {
		isLoading = true
		diffCon.getDifficulties(language: language) { difficulties, error in
			allDifficulties = difficulties
			if selectedDifficultyID == "" && difficulties.count > 0  && setDiff {
				selectedDifficultyID = difficulties[0].id
			}
			self.isLoading = false
		}
	}
}

#Preview {
	LessonDifficultyPickerView(selectedDifficultyID: .constant(""), language: "English")
}
