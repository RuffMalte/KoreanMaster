//
//  InSessionLessonGoalExampleView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonGoalExampleView: View {
	
	var example: LessonGoalExample
	
    var body: some View {
		HStack {
			
			//ICONS are from: https://www.dicebear.com/styles/bottts/
			Image("bottts-\(Int.random(in: 1...20))")
				.resizable()
				.scaledToFit()
				.frame(width: 50, height: 50)
			
		
		
			
			VStack(alignment: .leading) {
				Text(example.koreanText)
					.font(.system(.headline, design: .rounded, weight: .bold))
				
				Text(example.translatedText)
					.font(.system(.body, design: .rounded, weight: .regular))
					.foregroundStyle(.secondary)
				
			}
		}
    }
}

#Preview {
	InSessionLessonGoalExampleView(example: LessonGoalExample.mutlipleExample[0])
}
