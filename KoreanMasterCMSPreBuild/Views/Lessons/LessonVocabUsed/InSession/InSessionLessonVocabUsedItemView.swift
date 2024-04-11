//
//  InSessionLessonVocabUsedItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonVocabUsedItemView: View {
	
	var vocab: Vocab
	
	@State private var isShowingDetail = false
	
    var body: some View {
		HStack {
			Spacer()
			VStack {
				Spacer()
				Text(vocab.koreanVocab)
					.font(.system(.title, design: .rounded, weight: .bold))
				
				Text(vocab.koreanSentence)
					.font(.system(.headline, design: .rounded, weight: .thin))
					.foregroundColor(.secondary)
				
				
				if isShowingDetail {
					Divider()

					VStack {
						Text(vocab.localizedVocab)
							.font(.system(.title, design: .rounded, weight: .bold))
						
						Text(vocab.localizedSentence)
							.font(.system(.headline, design: .rounded, weight: .thin))
							.foregroundColor(.secondary)
					}
					VStack {
						Text("- " + vocab.partOfSpeech)
					}
					.padding()
				} else {
					Text("Tap to show details")
						.font(.system(.subheadline, design: .rounded, weight: .thin))
						.foregroundColor(.secondary)
						.padding()
				}
				
				
				Spacer()
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
		.onTapGesture {
			withAnimation {
				isShowingDetail.toggle()
			}
		}
    }
}

#Preview {
	InSessionLessonVocabUsedItemView(vocab: Vocab.example)
}
