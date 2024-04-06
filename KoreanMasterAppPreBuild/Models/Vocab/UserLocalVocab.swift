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
	
	
	init(
		id: String = UUID().uuidString,
		koreanVocab: String,
		koreanSentence: String? = nil,
		localizedVocab: String,
		selectedLanguage: String,
		partOfSpeech: String? = nil,
		localizedSentence: String? = nil,
		wikiUrl: String? = nil
	) {
		self.id = id
		self.koreanVocab = koreanVocab
		self.koreanSentence = koreanSentence
		self.localizedVocab = localizedVocab
		self.selectedLanguage = selectedLanguage
		self.partOfSpeech = partOfSpeech
		self.localizedSentence = localizedSentence
		self.wikiUrl = wikiUrl
	}
	
	func review(action: AnkiActionEnum) {
		reviewCount += 1 // Increment review count
		
		let changes = calculateReviewChanges(action: action)
		interval = changes.newInterval
		ease = changes.newEase
		
		lastReviewed = Date() // Update the last reviewed date to now
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
			return "today"
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
			.again: 1 / newEase, // Use a fraction of the ease factor for 'again' to reduce the interval
			.hard: 1.2,         // Slightly increase the interval
			.good: newEase,     // Use the ease factor as the multiplier for 'good'
			.easy: newEase * 1.5  // Use 150% of the ease factor for 'easy'
		]
		
		// Dynamic minimum intervals based on action
		let dynamicMinimumIntervals: [AnkiActionEnum: Double] = [
			.again: 12,
			.hard: 16,
			.good: 24,
			.easy: 24 * 3
		]
		
		let baseInterval: Double = 12
		var newInterval: Double
		
		if reviewCount <= 1 || action == .again {
			// For the first review or if the review is 'again', reset to a base interval
			newInterval = baseInterval
		} else {
			// Calculate new interval based on previous interval, with a cap at a maximum interval
			let multiplier = intervalMultiplier[action] ?? 1
			newInterval = interval * multiplier
			// Apply the dynamic minimum interval based on the action
			let actionMinimumInterval = dynamicMinimumIntervals[action] ?? baseInterval
			newInterval = max(newInterval, actionMinimumInterval)
		}
		
		// Ensure new ease does not fall below the minimum ease
		newEase = max(newEase, minimumEase)
		
		return (newInterval, newEase)
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
