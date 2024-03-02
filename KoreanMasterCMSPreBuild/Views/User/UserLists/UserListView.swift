//
//  UserListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct UserListView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
		NavigationStack {
			Form {
				List {
					Button {
						loginCon.getAllFirestoreUsers()
					} label: {
						Label("Get all users", systemImage: "arrow.right.circle.fill")
					}
					
					ForEach(loginCon.allFirestoreUsers) { user in
						NavigationLink {
							Text(user.displayName)
						} label: {
							UserCellView(user: user)
						}
					}
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
