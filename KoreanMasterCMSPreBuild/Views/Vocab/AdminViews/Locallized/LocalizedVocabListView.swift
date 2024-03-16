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
	var filterdVocab: [Vocab] {
		if searchText.isEmpty {
			return vocab
		} else {
			return vocab.filter { $0.localizedVocab.contains(searchText) || $0.koreanVocab.contains(searchText) || $0.localizedSentence.contains(searchText) || $0.koreanSentence.contains(searchText) }
		}
	}
	
	@State var isShowingAddVocab: Bool = false
	@State var searchText: String = ""
	@StateObject var vocabCon = VocabController()
	
	
    var body: some View {
		VStack {
			if vocabCon.isLoadingVocabs {
				ProgressView()
			} else {
				if filterdVocab.isEmpty {
					ContentUnavailableView {
						Image(systemName: "text.book.closed.fill")
					} description: {
						Text("No vocab found")
					} actions: {
						if !searchText.isEmpty {
							Button {
								isShowingAddVocab.toggle()
							} label: {
								Label("Add \(searchText)", systemImage: "plus")
							}
							.buttonStyle(.borderedProminent)
						}
					}
				} else {
					List {
						ForEach(filterdVocab) { vocab in
							NavigationLink {
								JSONView(model: vocab)
							} label: {
								VocabDetailSmallCellView(vocab: vocab, currentLanguage: language)
							}
						}
					}
				}
			}
		}
		.searchable(text: $searchText, prompt: "Search") {
			ForEach(vocab.filter { $0.localizedVocab.contains(searchText) || $0.koreanVocab.contains(searchText) || $0.localizedSentence.contains(searchText) || $0.koreanSentence.contains(searchText) }) { vocab in
				Text(vocab.localizedVocab)
					.searchCompletion(vocab.localizedVocab)
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
			ModifyVocabSheetView(vocab: Vocab.empty, language: language, preSelectedLocalizedVocab: searchText.isEmpty ? nil : searchText)
		}
    }
	
	func getVocab() {
		vocabCon.getVocab(language: language) { vocab, error in
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
