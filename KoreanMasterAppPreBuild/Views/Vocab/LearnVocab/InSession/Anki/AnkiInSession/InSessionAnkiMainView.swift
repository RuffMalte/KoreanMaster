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
	
	@State var currentVocabIndex: Int = 0
	@State private var isShowingAnkiButtons: Bool = false
	
	
	
    var body: some View {
		VStack {
			VStack {
				Spacer()
				HStack {
					Spacer()
						
					
					Text(localVocabs[currentVocabIndex].localizedVocab)
						.font(.system(.title, design: .rounded, weight: .bold))
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
			
			
			
			
				
			HStack(spacing: 10) {
				if isShowingAnkiButtons {
					ForEach(AnkiActionEnum.allCases, id: \.self) { action in
						AnkiButtonItemView(
							ankiAction: action,
							nextTimeVocabOccurrence: localVocabs[currentVocabIndex].predictedNextReviewDate(for: action)
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
			localVocabs[currentVocabIndex].review(action: ankiAction)
			if currentVocabIndex == localVocabs.count - 1 {
				endFunction()
				return
			}
			currentVocabIndex += 1
			isShowingAnkiButtons = false
		}
	}
	
}

#Preview {
	InSessionAnkiMainView(localVocabs: UserLocalVocab.multipleExampleVocabs, endFunction: { print("Ending") })
		.padding()
}
