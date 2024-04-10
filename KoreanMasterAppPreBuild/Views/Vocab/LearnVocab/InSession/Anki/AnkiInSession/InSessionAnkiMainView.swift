//
//  InSessionAnkiMainView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 30.03.24.
//

import SwiftUI

struct InSessionAnkiMainView: View {
	
	var localVocabs: [UserLocalVocab]
	
	var endFunction: () -> Void
	
	@State private var currentVocab: UserLocalVocab?
	@State private var isShowingAnkiButtons: Bool = false
	
	
	
    var body: some View {
		VStack {
			VStack {
				Spacer()
				HStack {
					Spacer()
					
					ScrollView {
						if let currentVocab = currentVocab {
							Text(currentVocab.koreanVocab)
								.padding()
								.font(.system(.title, design: .rounded, weight: .bold))

							
							
							if isShowingAnkiButtons {
								Divider()
								
								VStack {
									Text(currentVocab.localizedVocab)
										.font(.system(.title, design: .rounded, weight: .regular))
								}
								.padding()
								
								
								VStack {
									Text("Sentence")
										.padding(4)
									Text(currentVocab.koreanSentence ?? "-")
										.font(.system(.title3, design: .rounded, weight: .regular))
									Text(currentVocab.localizedSentence ?? "-")
										.font(.system(.title3, design: .rounded, weight: .regular))
								}
								.padding()
								
								if let info = currentVocab.partOfSpeech {
									VStack {
										Text("Info")
											.padding(4)
										Text("• " + info)
											.font(.system(.title3, design: .rounded, weight: .regular))
									}
									.padding()
								}
								
								
								if currentVocab.isMastered {
									Image(systemName: "star.fill")
										.foregroundStyle(.yellow.gradient)
										.font(.subheadline)
								}
								
								Spacer()
							}
						}
					}
					.foregroundStyle(.primary)
					.padding()
					
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
			.onTapGesture {
				withAnimation {
					isShowingAnkiButtons = true
				}
			}
			.onAppear {
				findAndSetNextVocab()
			}
			
			
			
			
			HStack(spacing: 10) {
				if let currentVocab = currentVocab, isShowingAnkiButtons {
					ForEach(AnkiActionEnum.allCases, id: \.self) { action in
						AnkiButtonItemView(
							ankiAction: action,
							nextTimeVocabOccurrence: currentVocab.predictedNextReviewDate(for: action)
						) {
							nextVocab(ankiAction: action)
						}
					}
				} else {
					Text("See Answer")
						.font(.system(.subheadline, design: .rounded, weight: .regular))
						.foregroundStyle(.secondary)
				}
			}
			.frame(height: 50)
		}
			
	}
    
	
	
	func nextVocab(ankiAction: AnkiActionEnum) {
		withAnimation {
			if let currentVocab = currentVocab {
				
				currentVocab.review(action: ankiAction)
				findAndSetNextVocab()
				
				isShowingAnkiButtons = false
			} else {
				endFunction()
			}
		}
	}
	
	func findAndSetNextVocab() {
		currentVocab = localVocabs.first(where: { $0.nextReviewDate() ?? Date.distantFuture < Date() })
		if currentVocab == nil {
			endFunction()
		}
	}

	
}

#Preview {
	InSessionAnkiMainView(localVocabs: UserLocalVocab.multipleExampleVocabs, endFunction: { print("Ending") })
		.padding()
}
