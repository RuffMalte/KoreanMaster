//
//  Vocab.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import Foundation
import Observation

@Observable
class Vocab: Identifiable, Codable {
	
	var id: String
	var koreanVocab: String
	var koreanSentence: String
	
	
	var localizedVocab: String
	var selectedLanguage: String
	var partOfSpeech: String
	var localizedSentence: String
	
	var wikiUrl: String
	
	
	init(
		id: String = UUID().uuidString,
		koreanVocab: String,
		koreanSentence: String,
		localizedVocab: String,
		selectedLanguage: String,
		partOfSpeech: String, 
		localizedSentence: String,
		wikiUrl: String
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
