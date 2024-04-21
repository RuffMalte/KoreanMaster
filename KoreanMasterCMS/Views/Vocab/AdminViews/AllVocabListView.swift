//
//  VocabLanguageListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

struct AllVocabListView: View {
	
	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var courseCon: CoursesController
	
    var body: some View {
		NavigationStack {
			if courseCon.isLoadingAllLessons {
				ProgressView()
			} else {
				List {
					ForEach(loginCon.allLanguages) { language in
						NavigationLink {
							LocalizedVocabListView(language: language.language)
						} label: {
							LanguageSmallDetailCellView(language: language)
						}
					}
				}
				.listStyle(SidebarListStyle())
				.navigationTitle("Vocab")
			}
		}
    }
}

#Preview {
    AllVocabListView()
}
