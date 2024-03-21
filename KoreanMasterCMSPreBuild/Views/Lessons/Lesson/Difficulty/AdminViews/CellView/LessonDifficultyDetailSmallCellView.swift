//
//  LessonDifficultyDetailSmallCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct LessonDifficultyDetailSmallCellView: View {
	
	@State var diff: LessonDiffuculty
	var currentLanguage: String
	
	@State private var isShowingEditDifficultySheet = false
	@StateObject var difficultyCon: DifficultyController
	
	var body: some View {
		VStack(alignment: .leading) {
			Label(diff.difficulty, systemImage: diff.SFicon)
				.font(.title2)
				.foregroundColor(Color(diff.color.toColor))
				.labelStyle(.titleAndIcon)
		}
		.contextMenu {
			Button {
				isShowingEditDifficultySheet.toggle()
			} label: {
				Label("Edit", systemImage: "pencil")
			}
			Button {
				difficultyCon.deleteDifficulties(with: [diff.id], language: currentLanguage) { bool, error in
					if let error = error {
						print("Error: \(error)")
					}
					print("Deleted: \(bool)")
				}
			} label: {
				Label("Delete", systemImage: "trash")
			}
			
		}
		.sheet(isPresented: $isShowingEditDifficultySheet) {
			ModifyDificultySheetView(lessonDifficulty: diff, language: currentLanguage, difficultyCon: difficultyCon)
		}
	}
}

#Preview {
	LessonDifficultyDetailSmallCellView(diff: LessonDiffuculty.example, currentLanguage: "English", difficultyCon: DifficultyController())
}
