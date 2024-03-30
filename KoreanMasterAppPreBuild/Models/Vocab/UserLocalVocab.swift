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
	

	func nextReviewDate() -> Date? {
		guard let lastReviewed = lastReviewed else { return nil }
		return Calendar.current.date(byAdding: .hour, value: Int(interval), to: lastReviewed)
	}
	
	
	func predictedNextReviewDate(for action: AnkiActionEnum) -> Date {
		let changes = calculateReviewChanges(action: action)
		let predictedInterval = changes.newInterval
		let currentLastReviewed = lastReviewed ?? Date()
		return Calendar.current.date(byAdding: .hour, value: Int(predictedInterval), to: currentLastReviewed)!
	}
	
	func calculateReviewChanges(action: AnkiActionEnum) -> (newInterval: Double, newEase: Double) {
		let baseInterval: Double = 1 // Base interval of 1 hour
		let maxInterval: Double = 14 * 24 // Max interval of 14 days, converted to hours
		let increaseFactorBase: Double = 1.2
		var increaseFactor: Double
		
		// Adjust the increase factor based on review count for more nuanced growth
		if reviewCount > 1 {
			increaseFactor = min(increaseFactorBase + (0.08 * Double(reviewCount - 1)), 2.0) // Cap increase factor to double for long-term reviews
		} else {
			increaseFactor = increaseFactorBase
		}
		
		var newInterval: Double
		var newEase = ease
		
		// Define max intervals for actions in hours
		let maxIntervals: [AnkiActionEnum: Double] = [
			.again: 24, // 1 day in hours
			.hard: 3 * 24, // 3 days in hours
			.good: 7 * 24, // 7 days in hours
			.easy: 14 * 24 // 14 days in hours
		]
		
		switch action {
		case .again:
			newEase = max(1.3, ease - 0.5)
			// Reset to base interval, but do not exceed max for "again"
			newInterval = baseInterval
		case .hard:
			newEase = max(1.3, ease - 0.15)
			// Calculate potential interval but cap at max for "hard"
			newInterval = min(interval * (increaseFactor - 0.1), maxIntervals[.hard]!)
		case .good:
			newEase += 0.1
			// Calculate potential interval but cap at max for "good"
			newInterval = min(interval * increaseFactor, maxIntervals[.good]!)
		case .easy:
			newEase += 0.2
			// Calculate potential interval but ensure it does not exceed max for "easy"
			newInterval = min(interval * (increaseFactor + 0.2), maxIntervals[.easy]!)
		}
		
		// Enforce the minimum interval of 1 hour
		newInterval = max(baseInterval, newInterval)
		
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
