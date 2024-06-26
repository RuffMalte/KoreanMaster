//
//  VocabDetailSmallCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import SwiftUI

struct VocabDetailSmallCellView: View {
	
	var vocab: Vocab
	var currentLanguage: String
	@State private var isShowingModifyVocabSheet: Bool = false
	@StateObject var vocabCon = VocabController()

    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(vocab.localizedVocab)
					.font(.system(.headline, design: .rounded, weight: .bold))
				Text(vocab.koreanVocab)
					.font(.system(.subheadline, design: .monospaced, weight: .semibold))
					.foregroundColor(.secondary)
			}
			
			Text("-")
				.font(.system(.title3, design: .default, weight: .bold))
			
			
			VStack(alignment: .leading) {
				Text(vocab.localizedSentence)
					.font(.system(.headline, design: .rounded, weight: .bold))

				Text(vocab.koreanSentence)
					.font(.system(.subheadline, design: .monospaced, weight: .semibold))
					.foregroundColor(.secondary)
			}
			
			Spacer()
			
			HStack {
				Text(vocab.partOfSpeech)
			}
			
		}
		.sheet(isPresented: $isShowingModifyVocabSheet) {
			ModifyVocabSheetView(vocab: vocab, language: currentLanguage)
		}
		.contextMenu {
			Button {
				isShowingModifyVocabSheet.toggle()
			} label: {
				Label("Modify", systemImage: "pencil")
					.labelStyle(.titleAndIcon)
			}
			Button {
				vocabCon.deleteVocabs(with: [vocab.id], language: currentLanguage) { bool, error in
					if let error = error {
						print(error)
					}
				}
			} label: {
				Label("Delete", systemImage: "trash")
					.labelStyle(.titleAndIcon)
			}
		}
    }
}

#Preview {
	VocabDetailSmallCellView(vocab: Vocab.example, currentLanguage: "English")
}
