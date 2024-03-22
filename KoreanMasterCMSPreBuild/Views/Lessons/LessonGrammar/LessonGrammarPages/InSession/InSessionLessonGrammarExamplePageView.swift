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
			Text(examplePage.title)
				.font(.system(.headline, design: .rounded, weight: .bold))
			
			Text(examplePage.desc)
				.font(.system(.subheadline, design: .default, weight: .regular))
			
			Text(examplePage.example)
				.font(.system(.body, design: .default, weight: .regular))
		}
    }
}
