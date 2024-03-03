//
//  LanguageSmallDetailCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 03.03.24.
//

import SwiftUI

struct LanguageSmallDetailCellView: View {
	
	var language: CourseLanguage
	
    var body: some View {
		Label(
			title: {
				Text(language.language)
			},
			icon: {
				Text(language.languageFlag)
			}
		)
		.labelStyle(.titleAndIcon)
    }
}

#Preview {
	LanguageSmallDetailCellView(language: CourseLanguage.simpleExample)
}
