//
//  ModifyLessonGrammarPageListCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 16.03.24.
//

import SwiftUI

struct ModifyLessonGrammarPageListCellView: View {
	
	@State var lessonGrammarPage: LessonGrammarPage
	var removeFuntion: () -> Void

    var body: some View {
		HStack {
			VStack {
				Text(lessonGrammarPage.id)
					.font(.system(.subheadline, design: .monospaced, weight: .regular))
				
				TextField("Title", text: $lessonGrammarPage.title)
				TextField("Desc", text: $lessonGrammarPage.desc)
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

#Preview {
	ModifyLessonGrammarPageListCellView(lessonGrammarPage: LessonGrammarPage.multipleExample[0], removeFuntion: {print("removing")})
}
