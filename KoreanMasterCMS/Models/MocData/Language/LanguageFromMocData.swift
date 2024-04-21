//
//  CourseLanguageMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

extension CourseLanguage {
	static var listSampleData: [CourseLanguage] {
		[
			CourseLanguage(language: "English", languageCode: "en", languageFlag: "🇬🇧"),
			CourseLanguage(language: "German", languageCode: "de", languageFlag: "🇩🇪"),
			CourseLanguage(language: "French", languageCode: "fr", languageFlag: "🇫🇷"),
			CourseLanguage(language: "Spanish", languageCode: "es", languageFlag: "🇪🇸"),
			CourseLanguage(language: "Italian", languageCode: "it", languageFlag: "🇮🇹"),
			CourseLanguage(language: "Portuguese", languageCode: "pt", languageFlag: "🇵🇹"),
			CourseLanguage(language: "Dutch", languageCode: "nl", languageFlag: "🇳🇱"),
			CourseLanguage(language: "Russian", languageCode: "ru", languageFlag: "🇷🇺"),
			CourseLanguage(language: "Polish", languageCode: "pl", languageFlag: "🇵🇱"),
			CourseLanguage(language: "Czech", languageCode: "cs", languageFlag: "🇨🇿"),
			CourseLanguage(language: "Turkish", languageCode: "tr", languageFlag: "🇹🇷"),
			CourseLanguage(language: "Arabic", languageCode: "ar", languageFlag: "🇸🇦"),
			CourseLanguage(language: "Chinese", languageCode: "zh", languageFlag: "🇨🇳"),
			CourseLanguage(language: "Japanese", languageCode: "ja", languageFlag: "🇯🇵"),
			CourseLanguage(language: "Korean", languageCode: "ko", languageFlag: "🇰🇷"),
			CourseLanguage(language: "Vietnamese", languageCode: "vi", languageFlag: "🇻🇳"),
			CourseLanguage(language: "Thai", languageCode: "th", languageFlag: "🇹🇭"),
			CourseLanguage(language: "Hindi", languageCode: "hi", languageFlag: "🇮🇳"),
		]
	}
	
	static var simpleExample: CourseLanguage = CourseLanguage(language: "German", languageCode: "de", languageFlag: "🇩🇪")
	
	
	static var emtpyCourseLanguage: CourseLanguage = CourseLanguage(language: "", languageCode: "", languageFlag: "")
}
						 
