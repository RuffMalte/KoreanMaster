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
		let components = calendar.dateComponents([.year, .month, .weekday, .day, .hour], from: now, to: nextTimeVocabOccurrence)

		func printMostSignificantComponent() {
			if let years = components.year, years != 0 {
				print("There are \(years) years until \(nextTimeVocabOccurrence)")
				return
			}
			if let months = components.month, months != 0 {
				print("There are \(months) months until \(nextTimeVocabOccurrence)")
				return
			}
			if let weeks = components.weekOfYear, weeks != 0 {
				print("There are \(weeks) weeks until \(nextTimeVocabOccurrence)")
				return
			}
			if let days = components.day, days != 0 {
				print("There are \(days) days until \(nextTimeVocabOccurrence)")
				return
			}
			if let hours = components.hour, hours != 0 {
				print("There are \(hours) hours until \(nextTimeVocabOccurrence)")
				return
			}
			print("The event is happening now or a date component was not properly set.")
		}
		
		printMostSignificantComponent()

		
		let difference = calendar.dateComponents([.minute, .hour, .day], from: now, to: nextTimeVocabOccurrence)
		
		if let day = difference.day, day > 0 {
			return "in \(day)d"
		} else if let hour = difference.hour, hour > 0 {
			return "in \(hour)h"
		} else if let minute = difference.minute, minute > 0 {
			return "in <1h"
		} else {
			return "soon"
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
