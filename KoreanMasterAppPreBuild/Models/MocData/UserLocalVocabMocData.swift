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
				selectedLanguage: "en",
				partOfSpeech: "noun",
				localizedSentence: "I love you",
				wikiUrl: "https://en.wikipedia.org/wiki/Love"
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
