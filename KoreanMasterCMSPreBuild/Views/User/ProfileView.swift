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

	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue
	
    var body: some View {
		Form {
			List {
				Text(loginCon.currentFirestoreUser?.displayName ?? "")
					.font(.system(.headline, design: .rounded, weight: .bold))
				
				Text(loginCon.currentFirestoreUser?.email ?? "")
					.font(.system(.subheadline, design: .monospaced, weight: .bold))
			
				
				MaltesColorPicker(color: $selectedTintColor, colorPickerStyle: .menu)
			
				Button {
					loginCon.logoutUser()
				} label: {
					Label("LogOut", systemImage: "arrowshape.turn.up.left.fill")
				}
				
				Button {
					loginCon.deleteCurrentUser()
				} label: {
					Label("Delete Account", systemImage: "trash.fill")
						.foregroundStyle(.red)
				}
				
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
