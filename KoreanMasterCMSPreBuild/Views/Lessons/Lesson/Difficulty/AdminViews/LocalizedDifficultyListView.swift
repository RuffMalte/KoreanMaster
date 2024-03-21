//
//  LocalizedDifficultyListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct LocalizedDifficultyListView: View {
	
	var language: String
	
	@StateObject var difficultyCon: DifficultyController = DifficultyController()
	@State private var lessonDifficulties: [LessonDiffuculty] = []
	
	@State private var isShowingAddDifficultySheet = false
	
    var body: some View {
		VStack {
			if difficultyCon.isLoadingDifficulty {
				ProgressView()
			} else {
				if !lessonDifficulties.isEmpty {
					List {
						ForEach(lessonDifficulties) { lessonDifficulty in
							NavigationLink {
								JSONView(model: lessonDifficulty)
							} label: {
								LessonDifficultyDetailSmallCellView(diff: lessonDifficulty, currentLanguage: language, difficultyCon: difficultyCon)
							}
						}
					}
				} else {
					ContentUnavailableView {
						Label("No difficulties found", systemImage: "exclamationmark.triangle")
					} actions: {
						Button {
							self.getDifficulties()
						} label: {
							Label("Refresh", systemImage: "arrow.clockwise")
						}
						Button {
							isShowingAddDifficultySheet.toggle()
						} label: {
							Label("Add new difficulty", systemImage: "plus")
						}
					}
					.buttonStyle(.borderedProminent)

				}
			}
		}
		.navigationTitle("\(language) difficulties")
		.onAppear {
			self.getDifficulties()
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					isShowingAddDifficultySheet.toggle()
				} label: {
					Label("Add new difficulty", systemImage: "plus")
				}
			}
			ToolbarItem(placement: .primaryAction) {
				Button {
					self.getDifficulties()
				} label: {
					Label("Refresh", systemImage: "arrow.clockwise")
				}
			}
		}
		.sheet(isPresented: $isShowingAddDifficultySheet) {
			ModifyDificultySheetView(lessonDifficulty: LessonDiffuculty.new, language: language, difficultyCon: difficultyCon)
		}
    }
	func getDifficulties() {
		difficultyCon.getDifficulties(language: language) { lessonDifficulties, error in
			guard error != nil else {
				self.lessonDifficulties = lessonDifficulties
				return
			}
		}
	}
}

#Preview {
	LocalizedDifficultyListView(language: "English")
}
