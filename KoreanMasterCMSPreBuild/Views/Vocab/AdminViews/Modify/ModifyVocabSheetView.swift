//
//  ModifyVocabSheetView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import SwiftUI

struct ModifyVocabSheetView: View {
	
	@State var vocab: Vocab
	var language: CourseLanguage
	
	@State private var dictionary: Dictionary?
	
	@StateObject var dictionaryCon = DictionaryController()
	
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
					Text("Language: \(language.language)")

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
					}
				}
				
				Section {
					if isLoading {
						ProgressView()
					} else {
						
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
						
						
						
					}
				}
				
				
			}
			.onAppear {
				vocab.selectedLanguage = language.language
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
						
						
						dismiss()
					} label: {
						Label("Save", systemImage: "checkmark")
					}

				}
			}
		}
    }
}

#Preview {
	ModifyVocabSheetView(vocab: Vocab.example, language: CourseLanguage.simpleExample)
}
