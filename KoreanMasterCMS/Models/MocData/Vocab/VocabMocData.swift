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
	
	static var examples: [Vocab] = [
		Vocab(
			koreanVocab: "예문",
			koreanSentence: "예문",
			localizedVocab: "example",
			selectedLanguage: "English",
			partOfSpeech: "noun",
			localizedSentence: "This is an example sentence.",
			wikiUrl: "https://en.wikipedia.org/wiki/Example"
		),
		Vocab(
			koreanVocab: "사랑",
			koreanSentence: "사랑",
			localizedVocab: "Love",
			selectedLanguage: "English",
			partOfSpeech: "noun",
			localizedSentence: "I love you.",
			wikiUrl: "https://en.wikipedia.org/wiki/Love"
		),
		Vocab(
			koreanVocab: "행복",
			koreanSentence: "저는 매우 행복합니다.",
			localizedVocab: "Happiness",
			selectedLanguage: "English",
			partOfSpeech: "noun",
			localizedSentence: "I am very happy.",
			wikiUrl: "https://en.wikipedia.org/wiki/Happiness"
		),
		Vocab(
			koreanVocab: "달리다",
			koreanSentence: "그는 빨리 달립니다.",
			localizedVocab: "Run",
			selectedLanguage: "English",
			partOfSpeech: "verb",
			localizedSentence: "He runs fast.",
			wikiUrl: "https://en.wikipedia.org/wiki/Running"
		),
		Vocab(
			koreanVocab: "먹다",
			koreanSentence: "저는 밥을 먹습니다.",
			localizedVocab: "Eat",
			selectedLanguage: "English",
			partOfSpeech: "verb",
			localizedSentence: "I eat rice.",
			wikiUrl: "https://en.wikipedia.org/wiki/Eating"
		),
		Vocab(
			koreanVocab: "음식",
			koreanSentence: "한국 음식은 맛있습니다.",
			localizedVocab: "Food",
			selectedLanguage: "English",
			partOfSpeech: "noun",
			localizedSentence: "Korean food is delicious.",
			wikiUrl: "https://en.wikipedia.org/wiki/Food"
		),
		Vocab(
			koreanVocab: "책",
			koreanSentence: "책을 읽습니다.",
			localizedVocab: "Book",
			selectedLanguage: "English",
			partOfSpeech: "noun",
			localizedSentence: "I read a book.",
			wikiUrl: "https://en.wikipedia.org/wiki/Book"
		),
		Vocab(
			koreanVocab: "학교",
			koreanSentence: "학교에 갑니다.",
			localizedVocab: "School",
			selectedLanguage: "English",
			partOfSpeech: "noun",
			localizedSentence: "I go to school.",
			wikiUrl: "https://en.wikipedia.org/wiki/School"
		),
		Vocab(
			koreanVocab: "공부",
			koreanSentence: "공부를 합니다.",
			localizedVocab: "Study",
			selectedLanguage: "English",
			partOfSpeech: "verb",
			localizedSentence: "I study.",
			wikiUrl: "https://en.wikipedia.org/wiki/Study"
		)
		
	]
	
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
