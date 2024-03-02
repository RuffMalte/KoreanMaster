//
//  LanguageFromMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

extension LanguageFrom {
	static var listSampleData: [LanguageFrom] {
		[
			LanguageFrom(language: "English", languageCode: "en", languageFlag: "🇬🇧"),
			LanguageFrom(language: "German", languageCode: "de", languageFlag: "🇩🇪"),
			LanguageFrom(language: "French", languageCode: "fr", languageFlag: "🇫🇷"),
			LanguageFrom(language: "Spanish", languageCode: "es", languageFlag: "🇪🇸"),
			LanguageFrom(language: "Italian", languageCode: "it", languageFlag: "🇮🇹"),
			LanguageFrom(language: "Portuguese", languageCode: "pt", languageFlag: "🇵🇹"),
			LanguageFrom(language: "Dutch", languageCode: "nl", languageFlag: "🇳🇱"),
			LanguageFrom(language: "Russian", languageCode: "ru", languageFlag: "🇷🇺"),
			LanguageFrom(language: "Polish", languageCode: "pl", languageFlag: "🇵🇱"),
			LanguageFrom(language: "Czech", languageCode: "cs", languageFlag: "🇨🇿"),
			LanguageFrom(language: "Turkish", languageCode: "tr", languageFlag: "🇹🇷"),
			LanguageFrom(language: "Arabic", languageCode: "ar", languageFlag: "🇸🇦"),
			LanguageFrom(language: "Chinese", languageCode: "zh", languageFlag: "🇨🇳"),
			LanguageFrom(language: "Japanese", languageCode: "ja", languageFlag: "🇯🇵"),
			LanguageFrom(language: "Korean", languageCode: "ko", languageFlag: "🇰🇷"),
			LanguageFrom(language: "Vietnamese", languageCode: "vi", languageFlag: "🇻🇳"),
			LanguageFrom(language: "Thai", languageCode: "th", languageFlag: "🇹🇭"),
			LanguageFrom(language: "Hindi", languageCode: "hi", languageFlag: "🇮🇳"),
		]
	}
	
	static var simpleExample: LanguageFrom = LanguageFrom(language: "German", languageCode: "de", languageFlag: "🇩🇪")
}
						 
