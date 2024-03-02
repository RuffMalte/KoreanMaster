//
//  LanguageCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct LanguageCellView: View {
	
	var language: CourseLanguage
	
	@State private var isShowingModifyLanguage: Bool = false
	
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
		.contextMenu {
			Button {
				isShowingModifyLanguage.toggle()
			} label: {
				Label("Modify", systemImage: "pencil")
			}
			//TODO: Implement delete language
//			Button {
//				print("Delete language")
//			} label: {
//				Label("Delete", systemImage: "trash")
//			}
		}
		.sheet(isPresented: $isShowingModifyLanguage){
			ModifyLanguageSheetView(language: language)
				.padding()
		}
	}
}

#Preview {
	LanguageCellView(language: CourseLanguage.simpleExample)
}
