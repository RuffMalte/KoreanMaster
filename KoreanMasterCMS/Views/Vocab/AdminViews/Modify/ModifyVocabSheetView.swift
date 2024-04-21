//
//  ModifyVocabSheetView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import SwiftUI

struct ModifyVocabSheetView: View {
	
	@State var vocab: Vocab
	var language: String
	var preSelectedLocalizedVocab: String?
	
	@StateObject var dictionaryCon = DictionaryController()
	@State private var dictionary: Dictionary?
	
	@StateObject var vocabCon = VocabController()
	
	
	@Environment(\.dismiss) private var dismiss
	@State private var isLoading: Bool = false
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Label("Automatic Translations will not always be correct! Please double check.", systemImage: "info.circle")
						.font(.system(.subheadline, design: .rounded))
				}
				
				Section {
					Text("ID: \(vocab.id)")
						.contextMenu {
							Button {
								PasteboardController().copyToPasteboard(string: vocab.id)
							} label: {
								Label("Copy", systemImage: "doc.on.doc")
									.labelStyle(.titleAndIcon)
							}
						}
				}
					
				Section {
					Text("Language: \(language)")

					HStack {
						TextField("Localized Vocab", text: $vocab.localizedVocab)
						Button {
							isLoading = true
							dictionaryCon.getDictForWord(word: vocab.localizedVocab) { dictionary, error in
								self.dictionary = dictionary
								
								self.isLoading = false
							}
						} label: {
							Label("Get data from Dictionary", systemImage: "magnifyingglass")
						}
						.buttonStyle(.borderedProminent)
					}
				}
				
				if isLoading {
					ProgressView()
				} else {
					Section {
						//Korean Vocab
						HStack {
							TextField("Korean Vocab", text: $vocab.koreanVocab)
								.foregroundStyle(.green)

							Button {
								isLoading = true
								TranslationController().getTranslation(for: vocab.localizedVocab, targetLang: "KO") { resutl, error in
									guard error != nil else {
										if let result = resutl {
											vocab.koreanVocab = result
										}
										isLoading = false
										return
									}
								}
							} label: {
								Label("Translate from localized", systemImage: "magnifyingglass")
							}
						}
						
						//Part of Sentence
						HStack {
							TextField("Part of Speach", text: $vocab.partOfSpeech)
							
							if let dictionary = dictionary {
								Menu {
									ForEach(dictionary.meanings ?? [], id: \.partOfSpeech) { definition in
										if let partOfSpeech = definition.partOfSpeech {
											Button {
												vocab.partOfSpeech = partOfSpeech
											} label: {
												Label(partOfSpeech, systemImage: "text.book.closed")
											}
										}
									}
								} label: {
									Label("Select from fetched dictionary", systemImage: "arrowtriangle.down.fill")
								}
							}
							
						}
						
						
						
						
						//Localized Sentence
						HStack {
							TextField("Localized Sentence", text: $vocab.localizedSentence)
							if let dictionary = dictionary, !vocab.partOfSpeech.isEmpty {
								Menu {
									ForEach(dictionary.meanings ?? [], id: \.partOfSpeech) { meaning in
										if vocab.partOfSpeech == meaning.partOfSpeech {
											ForEach(meaning.definitions ?? [], id: \.definition) { definition in
												if definition.example != nil && definition.example != "" {
													Button {
														vocab.localizedSentence = definition.example ?? ""
													} label: {
														Label(definition.example ?? "", systemImage: "text.book.closed")
													}
												}
											}
										}
									}
								} label: {
									Label("Select from fetched dictionary", systemImage: "arrowtriangle.down.fill")
								}
							}
						}
						
						//Korean Sentence
						HStack {
							TextField("Korean Sentence", text: $vocab.koreanSentence)
								.foregroundStyle(.green)

							if !vocab.localizedSentence.isEmpty {
								Button {
									isLoading = true
									TranslationController().getTranslation(for: vocab.localizedSentence, targetLang: "KO") { result, error in
										guard error != nil else {
											if let result = result {
												vocab.koreanSentence = result
											}
											isLoading = false
											return
										}
									}
								} label: {
									Label("Translate localized Sentence to Korean", systemImage: "magnifyingglass")
								}
							}
						}
					
						
						//Wiki
						HStack {
							TextField("Wiki link", text: $vocab.wikiUrl)
							if let dict = dictionary {
								Menu {
									ForEach(dict.sourceUrls ?? [], id: \.hashValue) { url in
										Button {
											vocab.wikiUrl = url
										} label: {
											Text(url)
										}
									}
								} label: {
									Label("Select from fetched dictionary", systemImage: "arrowtriangle.down.fill")
								}
							}
						}
					}
				}
				
				
			}
			.onAppear {
				vocab.selectedLanguage = language
				if let preSelectedLocalizedVocab = preSelectedLocalizedVocab {
					vocab.localizedVocab = preSelectedLocalizedVocab
				}
			}
			.textFieldStyle(.roundedBorder)
			.padding()
			.navigationTitle("Add or edit vocab")
			.toolbar {
				ToolbarItem(placement: .automatic) {
					Button(role: .cancel) {
						dismiss()
					} label: {
						Label("Cancel", systemImage: "xmark")
					}
				}
				
				ToolbarItem(placement: .automatic) {
					Button {
						vocabCon.saveVocab(vocab: vocab, language: language) { bool, error in
							guard error != nil else {
								dismiss()
								return
							}
						}
					} label: {
						Label("Save", systemImage: "checkmark")
					}
					.buttonStyle(.borderedProminent)
				}
			}
		}
    }
}

#Preview {
	ModifyVocabSheetView(vocab: Vocab.example, language: "English")
}
