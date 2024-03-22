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
				if let pages = grammar.LessonGrammarPages, pages.indices.contains(currentExampleIndex) {
					InSessionLessonGrammarExamplePageView(examplePage: pages[currentExampleIndex])
					
					
					HStack {
						Button("Previous") {
							withAnimation {
								currentExampleIndex = max(currentExampleIndex - 1, 0)
							}
						}
						
						Button("Next") {
							withAnimation {
								currentExampleIndex = min(currentExampleIndex + 1, pages.count - 1)
							}
						}
					}
					
				} else {
					ContentUnavailableView("No Pages found", systemImage: "exclamationmark.triangle.fill")
				}

				
				
			}
		}
	}
}


