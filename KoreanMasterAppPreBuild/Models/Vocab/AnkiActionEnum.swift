//
//  AnkiActionEnum.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 30.03.24.
//

import SwiftUI

enum AnkiActionEnum: CaseIterable {
	case again
	case hard
	case good
	case easy
	
	var toLocalized: LocalizedStringKey {
		switch self {
		case .again:
			return "Again"
		case .hard:
			return "Hard"
		case .good:
			return "Good"
		case .easy:
			return "Easy"
		}
	}
	
	var getColor: Color {
		switch self {
		case .again:
			return .red
		case .hard:
			return .orange
		case .good:
			return .yellow
		case .easy:
			return .green
		}
	}
}
