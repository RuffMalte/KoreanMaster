//
//  VocabMode.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import Foundation

enum VocabMode: String, CaseIterable {
	
	case anki
	case flashcards
	case quiz
	
	
	var toString: String {
		switch self {
		case .anki:
			return "Anki"
		case .flashcards:
			return "Flashcards"
		case .quiz:
			return "Quiz"
		}
	}
}
