//
//  WelcomeMessage.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import Foundation

class AllWelcomeMessageLocalized: Identifiable, Codable {
	var id: String
	var language: String
	var localizedWelcomeMessages: [LocalizedWelcomeMessage]
	
	init(
		id: String = UUID().uuidString,
		language: String,
		localizedWelcomeMessages: [LocalizedWelcomeMessage] = []
	) {
		self.id = id
		self.language = language
		self.localizedWelcomeMessages = localizedWelcomeMessages
	}
	
}

class LocalizedWelcomeMessage: Identifiable, Codable {
	var id: String = UUID().uuidString
	var welcomeMessage: String
	var translation: String
	
	init(
		id: String = UUID().uuidString,
		welcomeMessage: String,
		translation: String
	) {
		self.id = id
		self.welcomeMessage = welcomeMessage
		self.translation = translation
	}
}
