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

	@State private var searchTextField: String = ""
	private var filteredLocalVocabs: [UserLocalVocab] {
		if searchTextField.isEmpty {
			return localVocabs
		} else {
			return localVocabs.filter { $0.localizedVocab.lowercased().contains(searchTextField.lowercased()) ||
				$0.koreanVocab.lowercased().contains(searchTextField.lowercased())
			}
		}
	}
	
	@State private var timeUntilNextReview: String = "Loading..."
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
    var body: some View {
		NavigationStack {
			ZStack {
				VStack(spacing: 10) {
					ScrollView(.vertical) {
						HStack {
							Spacer()
							
							VStack(alignment: .leading, spacing: 25) {
								if isTimeToLearnAgain {
									Gauge(
										value: Double(localVocabs.filter { $0.reviewCount > 1 && $0.nextReviewDate() ?? Date() < Date() }.count) / Double(localVocabs.count),
										label: {
											Text("Learned")
										})
									.gaugeStyle(.linearCapacity)
									
									
									HStack {
										Spacer()
										
										Label {
											VStack(alignment: .leading) {
												Text(localVocabs.filter { 
													$0.reviewCount < 1
												}.count.description)
													.font(.headline)
												Text("Not studied")
													.font(.subheadline)
											}
										} icon: {
											Image(systemName: "rectangle.stack")
										}
										
										Spacer()
										
										Label {
											VStack(alignment: .leading) {
												Text(localVocabs.filter {
													$0.reviewCount > 1 && $0.nextReviewDate() ?? Date() < Date()
												}.count.description)
													.font(.headline)
												Text("To review")
													.font(.subheadline)
											}
										} icon: {
											Image(systemName: "graduationcap.fill")
										}
										
										Spacer()
									}
									.padding()
									
									.background {
										RoundedRectangle(cornerRadius: 16)
											.foregroundStyle(.tint.opacity(0.2))
										
									}
								} else {
									HStack {
										Spacer()
										Label {
											VStack(alignment: .leading) {
												Text("Next review in")
													.font(.system(.subheadline, design: .default, weight: .regular))
												Text("\(timeUntilNextReview)")
													.font(.system(.headline, design: .monospaced, weight: .bold))
											}
										} icon: {
											Image(systemName: "timer")
												.font(.system(.title3, design: .default, weight: .bold))
										}
										
										Spacer()
									}
									.padding(.vertical)
								}
							}
							.padding()
							.background {
								RoundedRectangle(cornerRadius: 16)
									.foregroundStyle(.bar)
									.shadow(radius: 5)
							}
							
							Spacer()
						}
						.font(.system(.headline, design: .rounded, weight: .bold))
						.padding(.top)
						
						
						VStack(alignment: .leading) {
							HStack {
								Text("Cards in Deck: \(localVocabs.count)")
									.font(.system(.callout, design: .default, weight: .bold))
								Spacer()
							}
							
							ForEach(filteredLocalVocabs) { localVocab in
								UserVocabCellView(vocab: localVocab)
							}
						}
						.padding(.top)
					}
				}
				.padding()
				
				VStack {
					Spacer()
					HStack {
						LearnVocabStartButtonView(toggleLearnVocabSheet: $isShowingVocabModeSelection)
							.disabled(!isTimeToLearnAgain || (localVocabs.filter { $0.nextReviewDate() ?? Date.distantFuture < Date() }.isEmpty))
						
						
						
						
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
//			.searchable(text: $searchTextField)
			.navigationTitle("Local Vocab")
			.sheet(isPresented: $isShowingVocabModeSelection) {
				
				//TODO: Implement VocabModeSelection
				InSessionVocabMainView(
					localVocabs: findCloseReviewDateVocabs(),
					selectedMode: .anki,
					canLearn: isTimeToLearnAgain
				)
				.presentationCompactAdaptation(.fullScreenCover)
			}
			.background {
				VStack {
					Rectangle()
						.foregroundStyle(.clear)
						.fadeToClear(startColor: .purple, endColor: .yellow, height: 250)
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
	func findCloseReviewDateVocabs() -> [UserLocalVocab] {
		let now = Date()
		return localVocabs.filter { $0.nextReviewDate() ?? Date.distantFuture < now }
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
