//
//  AnkiButtonItemView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

struct AnkiButtonItemView: View {
	
	var ankiAction: AnkiButtonAction
	var nextTimeVocabOccurrence: Date
	var action: (() -> Void)?
	
	enum AnkiButtonAction {
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
	
	
    var body: some View {
		Button {
			action?()
		} label: {
			HStack {
				VStack(alignment: .leading, spacing: 2) {
					Text(ankiAction.toLocalized)
						.font(.system(.headline, design: .rounded, weight: .bold))
						.foregroundStyle(.white)
					
					
					Label {
						Text(nextTimeVocabOccurrence, format: .dateTime.day())
					} icon: {
						Text("<")
					}
					.foregroundStyle(.white)
					.font(.system(.caption, design: .monospaced, weight: .regular))
				
				}
			}
		}
		.padding(10)
		.frame(width: 80)
		.buttonStyle(.plain)
		.background {
			RoundedRectangle(cornerRadius: 8)
				.foregroundStyle(ankiAction.getColor)
				.shadow(radius: 5)
		}
		
    }
}

#Preview {
	HStack(spacing: 10) {
		AnkiButtonItemView(ankiAction: .again, nextTimeVocabOccurrence: Date())
		AnkiButtonItemView(ankiAction: .hard, nextTimeVocabOccurrence: Date())
		AnkiButtonItemView(ankiAction: .good, nextTimeVocabOccurrence: Date())
		AnkiButtonItemView(ankiAction: .easy, nextTimeVocabOccurrence: Date())
	}
}
