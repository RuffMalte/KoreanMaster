//
//  AllLocalVocabView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI
import SwiftData

struct AllLocalVocabView: View {
	
	@Query var localVocabs: [UserLocalVocab]
	@Environment(\.modelContext) var modelContext
	
	@State private var isShowingVocabModeSelection = false
	
    var body: some View {
		NavigationStack {
			ZStack {
				ScrollView(.vertical) {
					VStack {
						ForEach(localVocabs) { localVocab in
							VStack {
								Text(localVocab.koreanVocab)
								Text(localVocab.localizedVocab)
							}
						}
						.onDelete { indexSet in
							for index in indexSet {
								modelContext.delete(localVocabs[index])
							}
						}
					}
				}
				
				VStack {
					Spacer()
					
					HStack {
						LearnVocabStartButtonView(toggleLearnVocabSheet: $isShowingVocabModeSelection)
						
						
						
						
						
						Button {
							
						} label: {
							Image(systemName: "plus")
								.font(.system(.headline, design: .rounded, weight: .bold))
								.padding()
								.frame(height: 50)
								.background {
									RoundedRectangle(cornerRadius: 10)
										.foregroundStyle(.bar)
										.shadow(radius: 5)
								}
						}
					}
					
					
				}
				.padding()
				
			}
			.navigationTitle("Local Vocab")
			.sheet(isPresented: $isShowingVocabModeSelection) {
				
				//TODO: Implement VocabModeSelection
				InSessionVocabMainView(localVocabs: localVocabs, selectedMode: .anki)
					.presentationCompactAdaptation(.fullScreenCover)
			}
			.background {
				VStack {
					Rectangle()
						.foregroundStyle(.clear)
						.fadeToClear(startColor: .purple, endColor: .yellow, height: 180)
						.ignoresSafeArea()
					
					Spacer()
				}
			}
		}
		
    }
}

#Preview {
    AllLocalVocabView()
}
