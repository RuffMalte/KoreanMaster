//
//  UserVocabCellView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 31.03.24.
//

import SwiftUI
import SwiftData

struct UserVocabCellView: View {
	
	var vocab: UserLocalVocab
	
	@Environment(\.modelContext) var modelContext

	@State var showDetail: Bool = false
	
	@State private var isShowingEditSheet = false
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 10) {
				HStack {
					if !vocab.dateStringFromToday(for: vocab.nextReviewDate()).isEmpty {
						Label(vocab.dateStringFromToday(for: vocab.nextReviewDate()).capitalized, systemImage: "clock")
							.font(.system(.subheadline, design: .rounded, weight: .bold))
							.foregroundStyle(.tint)
					}
					Spacer()
					
					if vocab.isMastered {
						Image(systemName: "star.fill")
							.foregroundStyle(.yellow.gradient)
							.font(.subheadline)
					}
				}
				HStack {
					Text(vocab.koreanVocab)
					Spacer()
					Text(vocab.localizedVocab)
				}
				.font(.system(.footnote, design: .rounded, weight: .bold))
				
				
				if showDetail {
					if let localsentence = vocab.localizedSentence, let koreansentence = vocab.koreanSentence {
						HStack {
							Text(koreansentence)
							Spacer()
							Text(localsentence)
						}
						.font(.system(.footnote, design: .rounded, weight: .regular))
						.foregroundStyle(.secondary)
					}
					
					HStack {
						if let partOfSpeech = vocab.partOfSpeech {
							Text("- " + partOfSpeech)
								.font(.system(.footnote, design: .rounded, weight: .bold))
								.foregroundStyle(.tint)
						}
						
						Spacer()
						if let wikiUrl = vocab.wikiUrl {
							
							Link(destination: URL(string: wikiUrl)!) {
								Image(systemName: "safari")
									.font(.system(.footnote, design: .rounded, weight: .bold))
									.foregroundStyle(.tint)
							}
						}
					}
				}
				
			}
			
			Spacer()
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 8)
				.foregroundStyle(.bar)
		}
		.contextMenu {
			Button {
				withAnimation {
					showDetail.toggle()
				}
			} label: {
				Label("Show Detail", systemImage: "info.circle")
			}
			Divider()
			Button {
				isShowingEditSheet.toggle()
			} label: {
				Label("Edit", systemImage: "pencil")
			}
			Button {
				vocab.reset()
			} label: {
				Label("Reset", systemImage: "arrow.counterclockwise")
			}
			Button(role: .destructive) {
				modelContext.delete(vocab)
			} label: {
				Label("Delete", systemImage: "trash")
			}
			
			
		}
		.sheet(isPresented: $isShowingEditSheet, content: {
			ModifyVocabSheetView(vocab: vocab)
				.presentationDetents([.medium, .large])
		})
		.onTapGesture {
			withAnimation(.bouncy) {
				showDetail.toggle()
			}
		}
    }
}

#Preview {
	UserVocabCellView(vocab: UserLocalVocab.singleExampleVocab)
		.padding()
}
