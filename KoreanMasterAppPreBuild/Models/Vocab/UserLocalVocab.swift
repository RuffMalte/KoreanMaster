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
