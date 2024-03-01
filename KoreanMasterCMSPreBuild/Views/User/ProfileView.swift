//
//  ProfileView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct ProfileView: View {
	
	@Environment(\.dismiss) var dismiss
	
	@EnvironmentObject var loginCon: LoginController

	
    var body: some View {
		Form {
			Section {
				Text("Display Name: \(loginCon.user?.displayName ?? "No display name")")
					.font(.system(.headline, design: .rounded, weight: .bold))
					
				Text("Email: \(loginCon.user?.email ?? "No email")")
					.font(.system(.subheadline, design: .monospaced, weight: .bold))
			}
			
			Section {
				Button {
					loginCon.logoutUser()
				} label: {
					Label("LogOut", systemImage: "arrowshape.turn.up.left.fill")
				}
				
				Button {
					loginCon.deleteCurrentUser()
				} label: {
					Label("Delete Account", systemImage: "trash.fill")
				}
				.foregroundStyle(.red)
			}
			
		}
		.toolbar {
			ToolbarItem(placement: .automatic) {
				Button(role: .cancel) {
					dismiss()
				} label: {
					Text("Close")
				}
			}
		}
    }
}

#Preview {
    ProfileView()
}
