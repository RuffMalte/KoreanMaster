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
	@EnvironmentObject var alertModal: AlertManager

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
					loginCon.logoutUser() { error, success in
						if let error = error {
							alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
						} else if success {
							alertModal.showAlert(.success, heading: "Success", subHeading: "Logged Out")
						}
					}
				} label: {
					Label("LogOut", systemImage: "arrowshape.turn.up.left.fill")
				}
				
				Button {
					loginCon.deleteCurrentUser() { success, error in
						if let error = error {
							alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
						} else if success {
							alertModal.showAlert(.success, heading: "Success", subHeading: "Deleted Account Out")
						}
					}
				} label: {
					Label("Delete Account", systemImage: "trash.fill")
						.foregroundStyle(.red)
				}
				
			}
			.withAlertModal(isPresented: $alertModal.isModalPresented)
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
