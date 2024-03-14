//
//  VocabMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import Foundation

extension Vocab {
	
	static var example: Vocab = Vocab(
		koreanVocab: "예문",
		koreanSentence: "예문",
		localizedVocab: "example",
		selectedLanguage: "English",
		partOfSpeech: "noun",
		localizedSentence: "This is an example sentence.",
		wikiUrl: "https://en.wikipedia.org/wiki/Example"
	)
	
	
	static var empty: Vocab = Vocab(
		koreanVocab: "",
		koreanSentence: "",
		localizedVocab: "",
		selectedLanguage: "",
		partOfSpeech: "",
		localizedSentence: "",
		wikiUrl: ""
	)
}
