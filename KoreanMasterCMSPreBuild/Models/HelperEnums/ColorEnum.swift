//
//  ColorEnum.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

enum ColorEnum: String, Codable, CaseIterable, Identifiable {
	var id: Self { return self }
	
	case red
	case orange
	case yellow
	case green
	case blue
	case indigo
	case purple
	case pink
	
	var toColor: Color {
		switch self {
		case .red:
			Color.red
		case .orange:
			Color.orange
		case .yellow:
			Color.yellow
		case .green:
			Color.green
		case .blue:
			Color.blue
		case .indigo:
			Color.indigo
		case .purple:
			Color.purple
		case .pink:
			Color.pink
		}
	}
	
	var toColorString: String {
		switch self {
		case .red:
			return "Red"
		case .orange:
			return "Orange"
		case .yellow:
			return "Yellow"
		case .green:
			return "Green"
		case .blue:
			return "Blue"
		case .indigo:
			return "Indigo"
		case .purple:
			return "Purple"
		case .pink:
			return "Pink"
		}
	}
}
