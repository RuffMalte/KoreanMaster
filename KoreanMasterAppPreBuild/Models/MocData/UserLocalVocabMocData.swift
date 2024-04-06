//
//  UserLocalVocabMocData.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

extension UserLocalVocab {
	
	
	static var multipleExampleVocabs: [UserLocalVocab] {
		[
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "love",
				selectedLanguage: "en"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "amour",
				selectedLanguage: "fr"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "Liebe",
				selectedLanguage: "de"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "amor",
				selectedLanguage: "es"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "amore",
				selectedLanguage: "it"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "amor",
				selectedLanguage: "pt"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "любовь",
				selectedLanguage: "ru"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "miłość",
				selectedLanguage: "pl"
			),
			UserLocalVocab(
				koreanVocab: "사랑",
				koreanSentence: "나는 너를 사랑해",
				localizedVocab: "amor",
				selectedLanguage: "pt"
			),
		]
	}
	
	static var singleExampleVocab: UserLocalVocab {
		UserLocalVocab(
			koreanVocab: "사랑",
			koreanSentence: "나는 너를 사랑해",
			localizedVocab: "love",
			selectedLanguage: "en",
			partOfSpeech: "noun",
			localizedSentence: "I love you",
			wikiUrl: "https://en.wikipedia.org/wiki/Love"
		)
	}
	
	static var newExampleVocab: UserLocalVocab {
		UserLocalVocab(
			koreanVocab: "",
			koreanSentence: "",
			localizedVocab: "",
			selectedLanguage: ""
		)
	}
	
}
