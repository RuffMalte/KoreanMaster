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
	@State var fetchVocabs: [Vocab] = [Vocab.example]
	
	@EnvironmentObject var alertModal: AlertManager
	
	var vGridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
	
    var body: some View {
		InSessionLessonHeaderView(title: vocab.title, subtitle: vocab.helpText) {
			VStack {
				Spacer()
				if isLoading {
					ProgressView()
				} else {
					VStack {
						GeometryReader { geo in
#if os(iOS)
							TabView {
								ForEach(fetchVocabs, id: \.id) { vocab in
									InSessionLessonVocabUsedItemView(vocab: vocab)
										.padding()
										.frame(width: geo.size.width, height: geo.size.height / 2)
								}
								
							}
							.tabViewStyle(.page(indexDisplayMode: .always))
							.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

#else
							ScrollView(.horizontal, showsIndicators: false) {
								HStack {
									ForEach(fetchVocabs, id: \.id) { vocab in
										InSessionLessonVocabUsedItemView(vocab: vocab)
											.frame(width: geo.size.width, height: geo.size.height)
									}
								}
								.scrollTargetLayout()
							}
							.scrollTargetBehavior(.viewAligned)
#endif
						}
						Spacer()
						InSessionSwitchSubLessonButtonView(switchLesson: switchLesson)
					}
				}
			}
		}
		.withAlertModal(isPresented: $alertModal.isModalPresented)
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
			if let error = error {
				alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
				self.isLoading = false
				
			} else {
				self.fetchVocabs = allVocab
				
				self.isLoading = false
			}
		}
	}
}

#Preview {
	InSessionLessonVocabUsedView(vocab: NewLessonVocabUsed.example, currentLanguage: "English", switchLesson: {})
		.padding()
}
