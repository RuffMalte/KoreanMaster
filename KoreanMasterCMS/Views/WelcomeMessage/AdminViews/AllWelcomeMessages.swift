//
//  AllWelcomeMessages.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import SwiftUI

struct AllWelcomeMessages: View {
	
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(loginCon.allLanguages) { language in
					NavigationLink {
						LocalizedWelcomeMessageListView(language: language.language)
					} label: {
						LanguageSmallDetailCellView(language: language)
					}
				}
			}
			.listStyle(SidebarListStyle())
			.navigationTitle("Welcome Messages")
			
			
			
			
			
		}
		
    }
}

#Preview {
    AllWelcomeMessages()
}
