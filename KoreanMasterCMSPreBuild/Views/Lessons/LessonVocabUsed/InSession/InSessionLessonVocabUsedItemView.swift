//
//  InSessionLessonVocabUsedItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonVocabUsedItemView: View {
	
	var vocab: Vocab
	
    var body: some View {
		HStack {
			Spacer()
			VStack {
				Text(vocab.koreanVocab)
					.font(.system(.headline, design: .rounded, weight: .bold))
				
				Text(vocab.koreanSentence)
					.font(.system(.footnote, design: .rounded, weight: .thin))
					.foregroundColor(.secondary)
			}
			Spacer()
		}
		.padding()
		.background {
			HStack {
				RoundedRectangle(cornerRadius: 16)
					.foregroundStyle(.bar)
			}
		}
    }
}

#Preview {
	InSessionLessonVocabUsedItemView(vocab: Vocab.example)
}
