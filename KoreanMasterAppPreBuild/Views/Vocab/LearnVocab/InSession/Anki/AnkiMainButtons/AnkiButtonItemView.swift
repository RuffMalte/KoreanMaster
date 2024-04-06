//
//  AnkiButtonItemView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

struct AnkiButtonItemView: View {
	var ankiAction: AnkiActionEnum
	var nextTimeVocabOccurrence: Date
	var action: (() -> Void)?
	
	private func formattedTimeUntilNextOccurrence() -> String {
		let now = Date()
		let calendar = Calendar.current
		
		// Ensure you're also considering minutes in your difference calculation
		let difference = calendar.dateComponents([.minute, .hour, .day], from: now, to: nextTimeVocabOccurrence)
		
		if let day = difference.day, day > 0 {
			return "in \(day)d"
		} else if let hour = difference.hour, hour > 0 {
			return "in \(hour)h"
		} else if let minute = difference.minute, minute > 0 {
			return "in <1h" // If there are any minutes to the next occurrence, show as less than an hour
		} else {
			return ""
		}
	}
	
	var body: some View {
		Button {
			action?()
			playFeedbackHaptic(.medium) 
		} label: {
			HStack {
				Spacer()
				VStack(alignment: .leading, spacing: 2) {
					Text(ankiAction.toLocalized)
						.font(.system(.headline, design: .rounded, weight: .bold))
						.foregroundStyle(.white)
					
					
					Text(formattedTimeUntilNextOccurrence())
						.lineLimit(1)	
						.foregroundStyle(.white)
						.font(.system(.caption, design: .monospaced, weight: .regular))
					
				}
				Spacer()
			}
		}
		.padding(.vertical)
		.buttonStyle(.plain)
		.background {
			RoundedRectangle(cornerRadius: 8)
				.fill(ankiAction.getColor)
				.shadow(radius: 5)
		}
	}
}


#Preview {
	HStack(spacing: 5) {
		AnkiButtonItemView(ankiAction: .again, nextTimeVocabOccurrence: Date())
		AnkiButtonItemView(ankiAction: .hard, nextTimeVocabOccurrence: Date())
		AnkiButtonItemView(ankiAction: .good, nextTimeVocabOccurrence: Date())
		AnkiButtonItemView(ankiAction: .easy, nextTimeVocabOccurrence: Date())
	}
}
