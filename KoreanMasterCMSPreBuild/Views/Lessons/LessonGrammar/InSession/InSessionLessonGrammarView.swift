//
//  InSessionLessonGrammarView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

import SwiftUI

struct InSessionLessonGrammarView: View {
	@State var grammar: LessonGrammar
	var switchLesson: () -> Void

	@State private var currentExampleIndex = 0
	
	var body: some View {
		InSessionLessonHeaderView(title: grammar.title, subtitle: grammar.desc) {
			VStack {
				InSessionLessonPageinatedItemsView(
					items: grammar.LessonGrammarPages ?? [],
					onEnd: switchLesson
				) { page in
					InSessionLessonGrammarExamplePageView(examplePage: page)
				}
			}
		}
	}
}


#Preview {
	InSessionLessonGrammarView(grammar: LessonGrammar.example, switchLesson: {
		
	})
	.padding()
}
