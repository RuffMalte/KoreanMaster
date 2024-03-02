//
//  LanguagesListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct LanguagesListView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
	@State private var isShowingAddLanguage: Bool = false
	
    var body: some View {
		Form {
			List {
				HStack {
					Button {
						isShowingAddLanguage.toggle()
//						loginCon.addLanguageToFirestore(language: CourseLanguage(language: "English", languageCode: "en", languageFlag: "🇬🇧"))
					} label: {
						Label("Add Language", systemImage: "plus.circle.fill")
					}
					Button {
						loginCon.getAllLanguages()
					} label: {
						Label("Fetch changes", systemImage: "arrow.clockwise")
					}
				}
				
				ForEach(loginCon.allLanguages) { language in
					LanguageCellView(language: language)
				}
			}
			
		}
		.navigationTitle("Languages for Learning Korean")
		.sheet(isPresented: $isShowingAddLanguage) {
			
		}
    }
}

#Preview {
    LanguagesListView()
}
