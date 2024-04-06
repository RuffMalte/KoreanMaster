//
//  ModifyVocabSheetView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 06.04.24.
//

import SwiftUI
import SwiftData

struct ModifyVocabSheetView: View {
	
	@Bindable var vocab: UserLocalVocab
	
	var onSaved: ((UserLocalVocab) -> Void)?
	
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var loginCon: LoginController
	
	@Query var localVocabs: [UserLocalVocab]
	@Environment(\.modelContext) var modelContext

	@State var vocabBeingEdited: UserLocalVocab?
	
	@State var koreanSentence: String = ""
	@State var localizedSentence: String = ""
	
	@State var partOfSpeech: String = ""
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Korean Vocab", text: $vocab.koreanVocab)
					TextField("Localized Vocab", text: $vocab.localizedVocab)
				}
				
				Section {
					TextField("Korean Sentence", text: $koreanSentence)
					TextField("Localized Sentence", text: $localizedSentence)
				}
				
				Section {
					TextField("Part of Speech", text: $partOfSpeech)
				}
			}
			.navigationTitle("Edit Vocab")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				vocabBeingEdited = vocab
				koreanSentence = vocab.koreanSentence ?? ""
				localizedSentence = vocab.localizedSentence ?? ""
				partOfSpeech = vocab.partOfSpeech ?? ""
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button {
						if let vocabBeingEdited = vocabBeingEdited {
							vocab.update(from: vocabBeingEdited)
						}
						dismiss()
					} label: {
						Text("Cancel")
					}
				}
				ToolbarItem(placement: .primaryAction) {
					Button {
						vocab.koreanSentence = koreanSentence
						vocab.localizedSentence = localizedSentence
						vocab.partOfSpeech = partOfSpeech
						
						vocab.selectedLanguage = loginCon.currentFirestoreUser!.languageSelected
						
						onSaved?(vocab)
						
						
						dismiss()
					} label: {
						Text("Save")
							.bold()
					}
					.disabled(vocab.koreanVocab.isEmpty && vocab.localizedVocab.isEmpty)
				}
				
			}
		}
    }
}

#Preview {
	ModifyVocabSheetView(vocab: UserLocalVocab.singleExampleVocab)
}
