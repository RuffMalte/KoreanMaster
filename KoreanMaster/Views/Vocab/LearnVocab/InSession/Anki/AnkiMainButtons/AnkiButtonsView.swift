//
//  AnkiButtonsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI

struct AnkiButtonsView: View {
    var body: some View {
		HStack(spacing: 10) {
			AnkiButtonItemView(ankiAction: .again, nextTimeVocabOccurrence: Date())
			AnkiButtonItemView(ankiAction: .hard, nextTimeVocabOccurrence: Date())
			AnkiButtonItemView(ankiAction: .good, nextTimeVocabOccurrence: Date())
			AnkiButtonItemView(ankiAction: .easy, nextTimeVocabOccurrence: Date())
		}
    }
}

#Preview {
    AnkiButtonsView()
}
