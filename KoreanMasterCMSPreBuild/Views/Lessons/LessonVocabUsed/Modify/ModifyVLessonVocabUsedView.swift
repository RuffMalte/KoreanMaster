//
//  ModifyVLessonVocabUsedView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

struct ModifyVLessonVocabUsedView: View {
	
	@State var vocabUsed: NewLessonVocabUsed
	
    var body: some View {
		Form {
			TextField("Title", text: $vocabUsed.title)
			TextField("Helptext", text: $vocabUsed.helpText)
			
			ForEach(vocabUsed.vocabIDs, id: \.self) { vocab in
				Text(vocab)
			}
		}
    }
}

#Preview {
	ModifyVLessonVocabUsedView(vocabUsed: NewLessonVocabUsed.example)
}
