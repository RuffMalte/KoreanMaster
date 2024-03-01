//
//  UserListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct UserListView: View {
    var body: some View {
		NavigationStack {
			Form {
				List {
					Text("User 1")
					Text("User 2")
					Text("User 3")
				}
			}
			.navigationTitle("Users")
			
			
		}
    }
}

#Preview {
	NavigationStack {
		UserListView()
	}
}
