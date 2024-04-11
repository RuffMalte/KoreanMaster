//
//  InSessionLessonGrammarExamplePageView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonGrammarExamplePageView: View {
	
	var examplePage: LessonGrammarPage
	
	
    var body: some View {
		VStack {
			VStack {
				Text(examplePage.title)
					.font(.system(.title, design: .rounded, weight: .bold))
					.foregroundStyle(.green.gradient)
				
				Text(examplePage.example)
					.font(.system(.title2, design: .default, weight: .regular))
					.foregroundStyle(.green)
			}
			.padding()
			
			HStack {
				Spacer()
				Text(examplePage.desc)
					.font(.system(.body, design: .default, weight: .regular))
				Spacer()
			}
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 16)
					.foregroundStyle(.bar)
			}
			.padding()
		}
    }
}

#Preview {
	InSessionLessonGrammarExamplePageView(examplePage: LessonGrammarPage.multipleExample[0])
}
