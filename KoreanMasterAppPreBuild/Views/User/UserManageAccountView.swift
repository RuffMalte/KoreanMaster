//
//  UserManageAccountView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct UserManageAccountView: View {
	
	@EnvironmentObject var loginCon: LoginController
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
							Circle()
								.frame(width: 75, height: 75, alignment: .center)
								.foregroundColor(selectedTintColor.toColor.opacity(0.75))
								.overlay {
									Text(user.displayName.first?.uppercased() ?? "")
										.font(.system(.title, design: .rounded, weight: .bold))
								}
							
							Button {
								//TODO: Update Pictures
							} label: {
								Text("Update Picture")
									.font(.system(.headline, design: .rounded, weight: .bold))
							}.buttonStyle(.bordered)

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
							loginCon.changeUserDisplayName(displayName: currentUser.displayName)
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
							print("doesn't work yet")
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
							loginCon.logoutUser()
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
							loginCon.deleteCurrentUser()
						}
					}
				}
			}
			.onAppear {
				currentUser = user
			}
			.navigationTitle("Your Account")
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
