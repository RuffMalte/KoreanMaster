//
//  ModifyLessonGrammarPageListCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 16.03.24.
//

import SwiftUI

struct ModifyLessonGrammarPageListCellView: View {
	
	@State var lessonGrammarPage: LessonGrammarPage
	var increaseOrder: () -> Void
	var decreaseOrder: () -> Void
	var removeFuntion: () -> Void

    var body: some View {
		HStack {
			
			VStack {
				Button(action: decreaseOrder) {
					Image(systemName: "arrow.up")
				}
				.disabled(lessonGrammarPage.order <= 1)


				Text("Page \(lessonGrammarPage.order)")

				Button(action: increaseOrder) {
					Image(systemName: "arrow.down")
				}
				.disabled(lessonGrammarPage.order >= 100)
				
			}
			
			VStack {
				Text(lessonGrammarPage.id)
					.font(.system(.subheadline, design: .monospaced, weight: .regular))
				
				TextField("Title", text: $lessonGrammarPage.title)
				TextField("Desc", text: $lessonGrammarPage.desc)
				TextField("Example", text: $lessonGrammarPage.example)
			}
			.textFieldStyle(.roundedBorder)
			
			Button {
				removeFuntion()
			} label: {
				Image(systemName: "xmark")
			}
		}
    }
}

