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
	var canLearn: Bool

	
	@Environment(\.dismiss ) var dismiss
	
	var body: some View {
		VStack {
			VStack {
				switch selectedMode {
				case .anki:
					if canLearn {
						InSessionAnkiMainView(localVocabs: localVocabs, endFunction: {
							dismiss()
						})
					} else {
						Text("You can't learn right now. Please wait until you can learn again.")
							.font(.title)
							.foregroundColor(.red)
							.padding()
					}
				case .flashcards:
					EmptyView()
				case .quiz:
					EmptyView()
				}
			}
			.overlay {
				VStack {
					HStack {
						Spacer()
						Button {
							dismiss()
						} label: {
							Image(systemName: "xmark")
								.font(.subheadline)
								.padding(8)
								.background {
									RoundedRectangle(cornerRadius: 8)
										.foregroundStyle(.bar)
										.shadow(radius: 5)
								}
						}
						.buttonStyle(.plain)
					}
					Spacer()
				}
				.padding()
			}
			.padding()
		}
	}
}

#Preview {
	InSessionVocabMainView(localVocabs: UserLocalVocab.multipleExampleVocabs, selectedMode: .anki, canLearn: true)
}
