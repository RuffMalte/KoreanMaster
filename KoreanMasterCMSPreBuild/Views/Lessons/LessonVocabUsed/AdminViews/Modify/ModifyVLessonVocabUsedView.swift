//
//  ModifyVLessonVocabUsedView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

struct ModifyVLessonVocabUsedView: View {
	
	@State var vocabUsed: NewLessonVocabUsed
	var language: String
	
	@StateObject var vocabCon: VocabController = VocabController()
	@State var vocabs: [Vocab] = []
	
	@State private var allLocalizedVocab: [Vocab] =  []
	var filterdVocabs: [Vocab] {
		if searchText.isEmpty {
			return []
		} else {
			return allLocalizedVocab.filter { $0.localizedVocab.contains(searchText) }
		}
	}
	@State private var searchText: String = ""
	@State private var isShowingAddVocabSheet: Bool = false
	
	
	@State private var isLoading: Bool = false
	
    var body: some View {
		Section {
			TextField("Title", text: $vocabUsed.title)
			TextField("Helptext", text: $vocabUsed.helpText)
			
			if isLoading {
				ProgressView()
			} else {
				VStack {
					ScrollView(.horizontal) {
						HStack {
							ForEach(vocabs, id: \.id) { vocab in
								VocabDetailListSmallCellView(vocab: vocab)
							}
						}
					}
					HStack {
						TextField("Search for a Vocab", text: $searchText)
						Button {
							searchText = ""
						} label: {
							Image(systemName: "xmark.circle.fill")
						}
						Button {
							getVocab()
						} label: {
							Image(systemName: "arrow.clockwise")
						}
						
						Button {
							isShowingAddVocabSheet.toggle()
						} label: {
							Image(systemName: "plus.app.fill")
						}
						.disabled(searchText.isEmpty && filterdVocabs.isEmpty)
					}
					ScrollView(.horizontal) {
						HStack {
							ForEach(filterdVocabs) { vocab in
								if filterdVocabs.isEmpty {
									Text("No Vocab found")
								} else {
									Button {
										if vocabUsed.vocabIDs.contains(vocab.id) {
											vocabs.removeAll { $0.id == vocab.id }
											vocabUsed.vocabIDs.removeAll { $0 == vocab.id }
										} else {
											vocabs.append(vocab)
											vocabUsed.vocabIDs.append(vocab.id)
										}
									} label: {
										HStack {
											if vocabUsed.vocabIDs.contains(vocab.id) {
												Image(systemName: "checkmark.circle.fill")
											}
											
											Text(vocab.localizedVocab)
										}
									}
									
									
								}
							}
						}
					}
					
				}
			}
		} header: {
			Text("New Vocab for this Lesson")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
		.onAppear {
			getVocab()
		}
		.sheet(isPresented: $isShowingAddVocabSheet) {
			let newVocab = Vocab(koreanVocab: "", koreanSentence: "", localizedVocab: searchText, selectedLanguage: "", partOfSpeech: "", localizedSentence: "", wikiUrl: "")
			
			ModifyVocabSheetView(vocab: newVocab, language: language)
		}
    }
	
	func getVocab() {
		self.isLoading = true
		vocabCon.getVocab(language: language) { allVocab, error in
			self.allLocalizedVocab = allVocab
			
			//filter ids from vocab List
			self.vocabs = allVocab.filter { vocab in
				vocabUsed.vocabIDs.contains(vocab.id)
			}
			
			self.isLoading = false
		}
	}
}

#Preview {
	ModifyVLessonVocabUsedView(vocabUsed: NewLessonVocabUsed.example, language: "English")
}
