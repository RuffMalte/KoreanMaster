//
//  VocabDetailListSmallCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 16.03.24.
//

import SwiftUI

struct VocabDetailListSmallCellView: View {
	
	@State var vocab: Vocab
	
	
	@State private var isShowingDetail: Bool = false
    var body: some View {
		VStack {
			Text(vocab.localizedVocab)
				.font(.system(.headline, design: .rounded, weight: .bold))
			
			Text(vocab.koreanVocab)
				.font(.system(.subheadline, design: .rounded, weight: .regular))
				.foregroundColor(.secondary)
		}
		.onTapGesture {
			isShowingDetail.toggle()
		}
		.popover(isPresented: $isShowingDetail) {
			VStack(alignment: .leading) {
				HStack {
					Text(vocab.localizedVocab)
					
					Spacer()
					
					Text(vocab.koreanVocab)
				}
				.font(.system(.headline, design: .rounded, weight: .bold))
				.padding(.vertical, 5)
				
				VStack {
					Text("-" + vocab.partOfSpeech)
				}
				.padding(.vertical, 2)
				
				VStack {
					Text(vocab.localizedSentence)
					Text(vocab.koreanSentence)
				}
				.font(.system(.subheadline, design: .rounded, weight: .regular))
				.foregroundColor(.secondary)
				
				Link(destination: URL(string: vocab.wikiUrl) ?? URL(string: "https://www.wikipedia.org")!) {
					Label("Wikipedia", systemImage: "safari")
				}
			}
			.padding()
		}
		
    }
}

#Preview {
	VocabDetailListSmallCellView(vocab: Vocab.example)
}
