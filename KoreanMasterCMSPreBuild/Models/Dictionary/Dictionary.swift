//
//  Dictionary.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import Foundation

// MARK: - WelcomeElement
class Dictionary: Codable {
	var word, phonetic: String?
	var phonetics: [Phonetic]?
	var origin: String?
	var meanings: [Meaning]?
	
	init(word: String?, phonetic: String?, phonetics: [Phonetic]?, origin: String?, meanings: [Meaning]?) {
		self.word = word
		self.phonetic = phonetic
		self.phonetics = phonetics
		self.origin = origin
		self.meanings = meanings
	}
}

// MARK: - Meaning
class Meaning: Codable {
	var partOfSpeech: String?
	var definitions: [Definition]?
	
	init(partOfSpeech: String?, definitions: [Definition]?) {
		self.partOfSpeech = partOfSpeech
		self.definitions = definitions
	}
}

// MARK: - Definition
class Definition: Codable {
	var definition, example: String?
	var synonyms, antonyms: [String?]?
	
	init(definition: String?, example: String?, synonyms: [String?]?, antonyms: [String?]?) {
		self.definition = definition
		self.example = example
		self.synonyms = synonyms
		self.antonyms = antonyms
	}
}

// MARK: - Phonetic
class Phonetic: Codable {
	var text, audio: String?
	
	init(text: String?, audio: String?) {
		self.text = text
		self.audio = audio
	}
}

