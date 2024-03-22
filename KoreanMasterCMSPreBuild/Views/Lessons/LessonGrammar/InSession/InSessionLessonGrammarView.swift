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
	@State private var currentExampleIndex = 0
	
	var body: some View {
		InSessionLessonHeaderView(title: grammar.title, subtitle: grammar.desc) {
			VStack {
				
				
				InSessionLessonGrammarExamplePageView(examplePage: grammar.LessonGrammarPages?[currentExampleIndex] ?? LessonGrammarPage.empty)
				
				
				
				HStack {
					Button("Previous") {
						if currentExampleIndex > 0 {
							currentExampleIndex -= 1
						}
					}
					Button("Next") {
						if currentExampleIndex < (grammar.LessonGrammarPages?.count ?? 0) - 1 {
							currentExampleIndex += 1
						}
					}
				}
			}
		}
	}
}


