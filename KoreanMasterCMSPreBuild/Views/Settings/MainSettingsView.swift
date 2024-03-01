//
//  MainSettingsView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct MainSettingsView: View {
    var body: some View {
		#if os(iOS)
		
		#elseif os(macOS)
		TabView {
			ProfileView()
				.tabItem {
					Image(systemName: "person.crop.circle.fill")
					Text("Profile")
				}
		}
		.tableColumnHeaders(.visible)
		
		#endif
    }
}

#Preview {
    MainSettingsView()
}
