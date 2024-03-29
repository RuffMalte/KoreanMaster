//
//  InSessionVocabMainView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

struct InSessionVocabMainView: View {
	
	var localVocabs: [UserLocalVocab]
	var selectedMode: VocabMode
	
    var body: some View {
		VStack {
			VStack {
				Spacer()
				HStack {
				
					Spacer()
					Text("jwd")
					Spacer()
				}
				Spacer()
			}
			.background {
				RoundedRectangle(cornerRadius: 20)
					.foregroundStyle(.secondary.opacity(0.2))
					.shadow(radius: 5)
			}
			.padding(.bottom)
			
			AnkiButtonsView()
		}
		.padding()
		
    }
}

#Preview {
	InSessionVocabMainView(localVocabs: UserLocalVocab.multipleExampleVocabs, selectedMode: .anki)
}
