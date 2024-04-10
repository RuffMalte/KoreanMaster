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
	var futureReviewDate: Date? = Date()
	
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
		futureReviewDate: Date? = Date(),
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
		self.futureReviewDate = futureReviewDate
		self.isMastered = isMastered
	}
	
	func review(action: AnkiActionEnum) {
		reviewCount += 1
		
		let changes = calculateReviewChanges(action: action)
		interval = changes.newInterval
		ease = changes.newEase
		
		lastReviewed = Date()
		futureReviewDate = Calendar.current.date(byAdding: .hour, value: Int(interval), to: lastReviewed!)
		checkForMastery()
	}

	
	func reset() {
		reviewCount = 0
		interval = 0
		ease = 0
		lastReviewed = Date()
		futureReviewDate = lastReviewed
	}
	
	func nextReviewDate() -> Date? {
		if let lastReviewed = lastReviewed {
			return Calendar.current.date(byAdding: .hour, value: Int(interval), to: lastReviewed)
		}
		return nil
	}
	
	func dateStringFromToday(for futureDate: Date?) -> String {
		guard let futureDate = futureDate else { return "Date not available" }
		let calendar = Calendar.current
		let now = Date()
		
		let days = calendar.dateComponents([.day], from: now, to: futureDate).day ?? 0
		if days == 0 {
			let hours = calendar.dateComponents([.hour], from: now, to: futureDate).hour ?? 0
			if hours > 0 {
				return "in \(hours) hour\(hours == 1 ? "" : "s")"
			} else {
				let minutes = calendar.dateComponents([.minute], from: now, to: futureDate).minute ?? 0
				if minutes > 0 {
					return "in \(minutes) minute\(minutes == 1 ? "" : "s")"
				}
				return "now"
			}
		} else if days > 0 {
			return "in \(days) day\(days == 1 ? "" : "s")"
		} else {
			return "Date has already passed"
		}
	}
	
	func predictedNextReviewDate(for action: AnkiActionEnum) -> Date {
		let changes = calculateReviewChanges(action: action)
		let predictedInterval = changes.newInterval
		let newDate = Date()
		return Calendar.current.date(byAdding: .hour, value: Int(predictedInterval), to: newDate)!
	}
	
	func checkForMastery() {
		let masteryEaseFactorThreshold = 2.5
		let masteryIntervalThreshold = 90 * 24 // 90 days * 24 hours per day
		
		if ease >= masteryEaseFactorThreshold && interval >= Double(masteryIntervalThreshold) {
			isMastered = true
		} else {
			isMastered = false
		}
	}
	
	func calculateReviewChanges(action: AnkiActionEnum) -> (newInterval: Double, newEase: Double) {
		let easeFactorAdjustment: [AnkiActionEnum: Double] = [
			.again: -0.20,  // Decrease ease factor by 20% for 'again'
			.hard: -0.15,   // Decrease ease factor by 15% for 'hard'
			.good: 0,       // Keep the ease factor the same for 'good'
			.easy: 0.15     // Increase ease factor by 15% for 'easy'
		]
		
		let minimumEase: Double = 1.3
		var newEase = ease + (easeFactorAdjustment[action] ?? 0)
		newEase = max(newEase, minimumEase)
		
		let intervalMultiplier: [AnkiActionEnum: Double] = [
			.again: 0.5,
			.hard: 0.75,
			.good: 1.0,
			.easy: 1.5
		]
		
		var newInterval = interval * (intervalMultiplier[action] ?? 1.0)
		newInterval = max(newInterval, dynamicMinimumIntervals(action, currentInterval: newInterval))
		
		return (newInterval, newEase)
	}
	
	func dynamicMinimumIntervals(_ action: AnkiActionEnum, currentInterval: Double) -> Double {
		switch action {
		case .again:
			return max(currentInterval, 12) // Ensuring minimum 1 hour and half of previous if it was larger
		case .hard:
			return max(currentInterval, 17) // Ensuring minimum 17 hours and 75% of previous
		case .good:
			return max(currentInterval, 25) // No reduction, ensuring minimum 25 hours
		case .easy:
			return max(currentInterval, 73) // Ensuring minimum 73 hours and an increase of 50%
		}
	}


	
	func update(from vocab: UserLocalVocab) {
		koreanVocab = vocab.koreanVocab
		koreanSentence = vocab.koreanSentence
		localizedVocab = vocab.localizedVocab
		selectedLanguage = vocab.selectedLanguage
		partOfSpeech = vocab.partOfSpeech
		localizedSentence = vocab.localizedSentence
		wikiUrl = vocab.wikiUrl
		reviewCount = vocab.reviewCount
		interval = vocab.interval
		ease = vocab.ease
		lastReviewed = vocab.lastReviewed
		futureReviewDate = vocab.futureReviewDate
		isMastered = vocab.isMastered
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
