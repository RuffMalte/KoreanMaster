//
//  LanguageCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct LanguageCellView: View {
	
	var language: CourseLanguage
	
    var body: some View {
		VStack {
			HStack {
				Label {
					Text(language.language)
				} icon: {
					Text(language.languageFlag)
				}
				Spacer()
			}
			HStack {
				Text(language.languageCode)
				Spacer()
				Text(language.id)
			}
			.foregroundStyle(.secondary)
			.font(.system(.footnote, design: .monospaced, weight: .medium))
		}
	}
}

#Preview {
	LanguageCellView(language: CourseLanguage.simpleExample)
}
