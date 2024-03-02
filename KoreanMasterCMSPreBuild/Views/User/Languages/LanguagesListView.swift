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
		NavigationStack {
			Form {
				List {
					HStack {
						Button {
							isShowingAddLanguage.toggle()
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
						NavigationLink {
							JSONView(model: language)
								.navigationTitle(language.language)
						} label: {
							LanguageCellView(language: language)
						}
						
						
					}
				}
				
			}
			.navigationTitle("Languages for Learning Korean")
			.sheet(isPresented: $isShowingAddLanguage) {
				ModifyLanguageSheetView()
					.padding()
			}
		}
    }
}

#Preview {
    LanguagesListView()
}
