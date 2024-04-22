//
//  NoUserSettingsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct NoUserSettingsView: View {
	
	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var alertModal: AlertManager

	
    var body: some View {
		Group {
			ContentUnavailableView(label: {
				Label("No User", systemImage: "person.fill.questionmark")
			}, description: {
				Text("How did you get here 🤨?")
			}, actions: {
				Button {
					loginCon.logoutUser() { error, success in
						if let error = error {
							alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
						} else if success {
							alertModal.showAlert(.success, heading: "Success", subHeading: "Logged Out")
						}
					}
				} label: {
					Label("Sign Up", systemImage: "person.fill.badge.plus")
				}
				.buttonStyle(.borderedProminent)
				Button {
					
				} label: {
					Label("Log In", systemImage: "person.fill")
				}
				.buttonStyle(.bordered)
			})
			.withAlertModal(isPresented: $alertModal.isModalPresented)

		}
    }
}

#Preview {
    NoUserSettingsView()
}
