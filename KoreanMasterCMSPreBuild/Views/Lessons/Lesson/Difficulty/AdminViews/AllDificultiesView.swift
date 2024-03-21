//
//  AllDificultiesView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct AllDificultiesView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(loginCon.allLanguages) { language in
					NavigationLink {
						LocalizedDifficultyListView(language: language.language)
					} label: {
						LanguageSmallDetailCellView(language: language)
					}
				}
			}
			.listStyle(SidebarListStyle())
			.navigationTitle("Difficulties")
		}
    }
}

#Preview {
    AllDificultiesView()
}
