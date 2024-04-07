//
//  UserLocalVocab.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import Foundation
import SwiftData

@Model
class UserLocalVocab: Identifiable {
	var id: String
	var koreanVocab: String
	var koreanSentence: String?
	
	
	var localizedVocab: String
	var selectedLanguage: String
	var partOfSpeech: String?
	var localizedSentence: String?
	
	var wikiUrl: String?
	
	
	
	var reviewCount: Int = 0
	var interval: Double = 0
	var ease: Double = 0
	var lastReviewed: Date? = Date()
	
	var isMastered: Bool = false
	
	init(
		id: String = UUID().uuidString,
		koreanVocab: String,
		koreanSentence: String? = nil,
		localizedVocab: String,
		selectedLanguage: String,
		partOfSpeech: String? = nil,
		localizedSentence: String? = nil,
		wikiUrl: String? = nil,
		reviewCount: Int = 0,
		interval: Double = 0,
		ease: Double = 0,
		lastReviewed: Date? = Date(),
		isMastered: Bool = false
	) {
		self.id = id
		self.koreanVocab = koreanVocab
		self.koreanSentence = koreanSentence
		self.localizedVocab = localizedVocab
		self.selectedLanguage = selectedLanguage
		self.partOfSpeech = partOfSpeech
		self.localizedSentence = localizedSentence
		self.wikiUrl = wikiUrl
		self.reviewCount = reviewCount
		self.interval = interval
		self.ease = ease
		self.lastReviewed = lastReviewed
		self.isMastered = isMastered

	}
	
	func review(action: AnkiActionEnum) {
		reviewCount += 1
		
		let changes = calculateReviewChanges(action: action)
		interval = changes.newInterval
		ease = changes.newEase
		
		lastReviewed = Date()
		checkForMastery()
	}
	
	func reset() {
		reviewCount = 0
		interval = 0
		ease = 0
		lastReviewed = Date()
	}
	
	func nextReviewDate() -> Date? {
		guard let lastReviewed = lastReviewed else { return nil }
		return Calendar.current.date(byAdding: .hour, value: Int(interval), to: lastReviewed)
	}
	
	func dateStringFromToday(for futureDate: Date?) -> String {
		guard let futureDate = futureDate else { return "Date not available" }
		let calendar = Calendar.current
		let now = Date()
		
		if calendar.isDateInToday(futureDate) {
			let components = calendar.dateComponents([.hour, .minute], from: now, to: futureDate)
			if let hours = components.hour, let minutes = components.minute {
				if hours > 0 || minutes > 0 {
					if hours > 0 {
						return "in \(hours) hour\(hours == 1 ? "" : "s")"
					} else if minutes > 0 {
						return "in \(minutes) minute\(minutes == 1 ? "" : "s")"
					}
				}
				return "now"
			}
		} else if calendar.isDateInTomorrow(futureDate) {
			return "tomorrow"
		} else {
			let startOfNow = calendar.startOfDay(for: now)
			let startOfFutureDate = calendar.startOfDay(for: futureDate)
			
			let components = calendar.dateComponents([.day], from: startOfNow, to: startOfFutureDate)
			if let days = components.day, days > 0 {
				switch days {
				case 1:
					return "in 1 day" // This is technically covered by isDateInTomorrow, but here for completeness
				case 2...30:
					return "in \(days) days"
				default:
					return "in more than a month"
				}
			}
		}
		return ""
	}

	
	func predictedNextReviewDate(for action: AnkiActionEnum) -> Date {
		let changes = calculateReviewChanges(action: action)
		let predictedInterval = changes.newInterval
		let currentLastReviewed = lastReviewed ?? Date()
		return Calendar.current.date(byAdding: .hour, value: Int(predictedInterval), to: currentLastReviewed)!
	}
	
	func checkForMastery() {
		
		let masteryEaseFactorThreshold = 2.5
		let masteryIntervalThreshold = 90 * 24
		
		if ease >= masteryEaseFactorThreshold && Int(interval) >= masteryIntervalThreshold {
			isMastered = true
		}
	}
	
	func calculateReviewChanges(action: AnkiActionEnum) -> (newInterval: Double, newEase: Double) {
		// Base ease factor adjustment values
		let easeFactorAdjustment: [AnkiActionEnum: Double] = [
			.again: -0.20, // Decrease ease factor by 20% for 'again'
			.hard: -0.15,  // Decrease ease factor by 15% for 'hard'
			.good: 0,      // Keep the ease factor the same for 'good'
			.easy: 0.15    // Increase ease factor by 15% for 'easy'
		]
		
		let minimumEase: Double = 1.3
		var newEase = max(minimumEase, ease + (easeFactorAdjustment[action] ?? 0))
		
		// Base interval multipliers
		let intervalMultiplier: [AnkiActionEnum: Double] = [
			.again: 0.5,   // Reduce the interval to half for 'again'
			.hard: 1.2,    // Slightly increase the interval
			.good: newEase, // Use the ease factor as the multiplier for 'good'
			.easy: newEase * 1.5  // Use 150% of the ease factor for 'easy'
		]
		
		// Dynamic minimum intervals based on action
		let dynamicMinimumIntervals: [AnkiActionEnum: Double] = [
			.again: 13,
			.hard: 17,
			.good: 25,
			.easy: 73  // 3 days expressed in hours
		]
		
		let baseInterval: Double = 12
		var newInterval: Double
		
		// Calculate new interval based on previous interval or base interval if first review
		let multiplier = intervalMultiplier[action] ?? 1
		newInterval = (reviewCount <= 1) ? baseInterval : interval * multiplier
		
		// Apply the dynamic minimum interval based on the action
		let actionMinimumInterval = dynamicMinimumIntervals[action] ?? baseInterval
		newInterval = max(newInterval, actionMinimumInterval)
		
		// Ensure new ease does not fall below the minimum ease
		newEase = max(newEase, minimumEase)
		
		return (newInterval, newEase)
	}


	func update(from vocab: UserLocalVocab) {
		self.koreanVocab = vocab.koreanVocab
		self.koreanSentence = vocab.koreanSentence
		self.localizedVocab = vocab.localizedVocab
		self.selectedLanguage = vocab.selectedLanguage
		self.partOfSpeech = vocab.partOfSpeech
		self.localizedSentence = vocab.localizedSentence
		self.wikiUrl = vocab.wikiUrl
		self.reviewCount = vocab.reviewCount
		self.interval = vocab.interval
		self.ease = vocab.ease
		self.lastReviewed = vocab.lastReviewed
		self.isMastered = vocab.isMastered
	}

}

extension UserLocalVocab {
	convenience init(from vocab: Vocab) {
		self.init(
			id: vocab.id,
			koreanVocab: vocab.koreanVocab,
			koreanSentence: vocab.koreanSentence,
			localizedVocab: vocab.localizedVocab,
			selectedLanguage: vocab.selectedLanguage,
			partOfSpeech: vocab.partOfSpeech,
			localizedSentence: vocab.localizedSentence,
			wikiUrl: vocab.wikiUrl
		)
	}
}
