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
	@State private var isTimeToLearnAgain: Bool = false

	
	@State private var timeUntilNextReview: String = "Loading..."
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
    var body: some View {
		NavigationStack {
			ZStack {
				VStack {
					
					
					
					if isTimeToLearnAgain {
						Text("Time to learn again!")
							.font(.title)
							.foregroundColor(.green)
							.padding()
					} else {
						Text("Next review in: \(timeUntilNextReview)")
							.font(.headline)
							.padding()
					}
					
					
					
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
				InSessionVocabMainView(localVocabs: localVocabs, selectedMode: .anki, canLearn: isTimeToLearnAgain)
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
			.onAppear {
				updateTimer()
			}
			.onReceive(timer) { _ in
				updateTimer()
			}
		}
		
    }
	func updateTimer() {
		guard let nextReviewDate = localVocabs.min(by: { $0.nextReviewDate() ?? Date.distantFuture < $1.nextReviewDate() ?? Date.distantFuture })?.nextReviewDate() else {
			timeUntilNextReview = "No reviews pending"
			isTimeToLearnAgain = true // No upcoming reviews, so it's always a good time to learn
			return
		}
		
		let now = Date()
		if nextReviewDate <= now {
			timeUntilNextReview = "Now"
			isTimeToLearnAgain = true
		} else {
			timeUntilNextReview = formattedTimeUntil(nextReviewDate: nextReviewDate)
			isTimeToLearnAgain = false
		}
	}
	
	func formattedTimeUntil(nextReviewDate: Date) -> String {
		let now = Date()
		let calendar = Calendar.current
		let difference = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: nextReviewDate)
		
		var components = [String]()
		if let day = difference.day, day > 0 { components.append("\(day)d") }
		if let hour = difference.hour, hour > 0 { components.append("\(hour)h") }
		if let minute = difference.minute, minute > 0 { components.append("\(minute)m") }
		if let second = difference.second, second > 0 { components.append("\(second)s") }
		
		return components.joined(separator: " ")
	}
}

#Preview {
    AllLocalVocabView()
}
