//
//  VocabLanguageListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

struct VocabLanguageListView: View {
	
	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var courseCon: CoursesController
	
    var body: some View {
		NavigationStack {
			if courseCon.isLoadingAllLessons {
				ProgressView()
			} else {
				List {
					
				}
				.listStyle(SidebarListStyle())
				.navigationTitle("Courses")
			}
		}
    }
}

#Preview {
    VocabLanguageListView()
}
