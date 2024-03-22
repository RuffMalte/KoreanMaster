//
//  InSessionLessonVocabUsedView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonVocabUsedView: View {
	
	@State var vocab: NewLessonVocabUsed
	var currentLanguage: String
	
	var switchLesson: () -> Void

	
	@StateObject var vocabCon: VocabController = VocabController()
	@State var isLoading: Bool = false
	@State var fetchVocabs: [Vocab] = []
	
	
	var vGridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
	
    var body: some View {
		InSessionLessonHeaderView(title: vocab.title, subtitle: vocab.helpText) {
			VStack {
				Spacer()
				if isLoading {
					ProgressView()
				} else {
					VStack {
						ScrollView {
							LazyVGrid(columns: vGridItemLayout) {
								ForEach(fetchVocabs, id: \.id) { vocab in
									InSessionLessonVocabUsedItemView(vocab: vocab)
								}
							}
						}
						Spacer()
						InSessionSwitchSubLessonButtonView(switchLesson: switchLesson)
					}
				}
			}
		}
		.onAppear {
			getVocab()
		}
		.onChange(of: vocab.vocabIDs) { oldValue, newValue in
			getVocab()
		}
    }
	func getVocab() {
		self.isLoading = true
		vocabCon.getVocab(with: vocab.vocabIDs, language: currentLanguage) { allVocab, error in
			self.fetchVocabs = allVocab
			
			self.isLoading = false
		}
	}
}

#Preview {
	InSessionLessonVocabUsedView(vocab: NewLessonVocabUsed.example, currentLanguage: "English", switchLesson: {})
}
