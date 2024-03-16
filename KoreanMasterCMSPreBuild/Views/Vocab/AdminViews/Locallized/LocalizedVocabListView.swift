//
//  LocalizedVocabListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import SwiftUI

struct LocalizedVocabListView: View {
	
	var language: String
	
	@State var vocab: [Vocab] = []
	@State var isShowingAddVocab: Bool = false
	@StateObject var vocabCon = VocabController()
	
	
    var body: some View {
		VStack {
			if vocabCon.isLoadingVocabs {
				ProgressView()
			} else {
				List {
					ForEach(vocab) { vocab in
						NavigationLink {
							JSONView(model: vocab)
						} label: {
							VocabDetailSmallCellView(vocab: vocab, currentLanguage: language)
						}
					}
				}
			}
		}
		.navigationTitle("\(language) Vocab")
		.onAppear {
			getVocab()
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					isShowingAddVocab.toggle()
				} label: {
					Label("Add new vocab", systemImage: "plus")
				}
			}
			
			ToolbarItem(placement: .primaryAction) {
				Button {
					getVocab()
				} label: {
					Label("Refresh", systemImage: "arrow.clockwise")
				}
			}
		}
		.sheet(isPresented: $isShowingAddVocab) {
			ModifyVocabSheetView(vocab: Vocab.empty, language: language)
		}
    }
	
	func getVocab() {
		vocabCon.getVocab(language: "English") { vocab, error in
			guard error != nil else {
				self.vocab = vocab
				return
			}
		}
	}
}

#Preview {
	LocalizedVocabListView(language: "English")
}
