//
//  UserManageAccountView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct UserManageAccountView: View {
	
	@EnvironmentObject var loginCon: LoginController
	@EnvironmentObject var alertModal: AlertManager

	@State private var isPresentingAlert = false
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .red

	@State private var currentUser: FirestoreUser = FirestoreUser.singleExample
	
    var body: some View {
		if let user = loginCon.currentFirestoreUser {
			Form {
				Section {
					HStack {
						Spacer()
						VStack {
							UserProfileDefaultCircleView()
						

						}
						Spacer()
					}
				}
				.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
				.listRowBackground(Color.clear)
				
				
				
				Section {
					HStack {
						TextField("Name", text: $currentUser.displayName)
							.autocapitalization(.words)
							.disableAutocorrection(true)
						
						Button {
							loginCon.changeUserDisplayName(displayName: currentUser.displayName) { newName, error in
								if let error = error {
									alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
								} else if let name = newName {
									alertModal.showAlert(.success, heading: "Success", subHeading: "Name updated to \(String(describing: name))")
								}
							}
						} label: {
							Image(systemName: "square.and.arrow.down")
								.font(.headline)
						}
						.buttonStyle(.borderedProminent)

					}
				} header: {
					Text("Name")
				}
				
				
				Section {
					HStack {
						TextField("email", text: $currentUser.email)
							.autocapitalization(.words)
							.disableAutocorrection(true)
						
						Button {
							
						} label: {
							Image(systemName: "square.and.arrow.down")
								.font(.headline)
						}
						.buttonStyle(.borderedProminent)
						
					}
				} header: {
					Text("Email")
				}
				
				
				
				Section {
					HStack {
						Spacer()
						Button {
							
						} label: {
							Text("Update Password")
						}
						.buttonStyle(.bordered)
						
						Spacer()

					}
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
					.listRowBackground(Color.clear)
				}
				
				
				Section {
					HStack {
						Button {
							loginCon.logoutUser() { error, success in
								if let error = error {
									alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
								} else if success {
									alertModal.showAlert(.success, heading: "Success", subHeading: "Logged Out")
								}
							}
						} label: {
							Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
						}
						.buttonStyle(.bordered)
						Spacer()
						
						Button(role: .destructive) {
							self.isPresentingAlert = true
						} label: {
							Label("Delete Account", systemImage: "trash")
								.foregroundStyle(.white)
								.font(.system(.body, design: .default, weight: .bold))
						}
						.buttonStyle(.borderedProminent)
						.tint(.red)
					}
				}
				.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
				.listRowBackground(Color.clear)
				.confirmationDialog(
					"Are you sure?",
					isPresented: $isPresentingAlert,
					titleVisibility: .visible
				) {
					Button("Yes", role: .destructive) {
						withAnimation {
							loginCon.deleteCurrentUser() { success, error in
								if let error = error {
									alertModal.showAlert(.error, heading: "Error", subHeading: error.localizedDescription)
								} else if success {
									alertModal.showAlert(.success, heading: "Success", subHeading: "Account Deleted")
								}
								
							}
						}
					}
				}
			}
			.onAppear {
				currentUser = user
			}
			.navigationTitle("Your Account")
			.withAlertModal(isPresented: $alertModal.isModalPresented)

		} else {
			NoUserSettingsView()
		}
		
    }
}

#Preview {
	NavigationStack {
		UserManageAccountView()
			.withEnvironmentObjects()
	}
}
