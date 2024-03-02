//
//  LanguageFrom.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import Foundation

class LanguageFrom: Identifiable, Encodable, Decodable {
	var id: String
	var language: String
	var languageCode: String
	var languageFlag: String
	
	init(
		id: String = UUID().uuidString,
		language: String,
		languageCode: String,
		languageFlag: String
	) {
		self.id = id
		self.language = language
		self.languageCode = languageCode
		self.languageFlag = languageFlag
	}
}
