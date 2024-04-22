//
//  UserProfileHeaderView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct UserProfileHeaderView: View {
	
	@EnvironmentObject var loginCon: LoginController
	
	
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .red

	var body: some View {
		HStack {
			Spacer()
			VStack(alignment: .center) {
				UserProfileDefaultCircleView()
				
				Text(loginCon.currentFirestoreUser?.displayName ?? "")
					.font(.system(.title3, design: .rounded, weight: .bold))
				
				Text(loginCon.currentFirestoreUser?.email ?? "")
					.font(.system(.footnote, design: .monospaced, weight: .regular))
					.foregroundColor(.secondary)
				
				NavigationLink {
					UserManageAccountView()
				} label: {
					HStack {
						HStack {
							Spacer()
							Text("Manage Account")
								.font(.headline)
							
							Spacer()
						}
						.padding(8)
						.background {
							RoundedRectangle(cornerRadius: 8)
								.foregroundStyle(.tint)
						}
						.shadow(radius: 5)
					}
				}

//				if loginCon.currentFirestoreUser?.isAdmin ?? false {
//					NavigationLink {
//						
//					} label: {
//						HStack {
//							Spacer()
//							Text("Admin Panel")
//								.font(.headline)
//							
//							Spacer()
//						}
//						.padding(8)
//						.background {
//							RoundedRectangle(cornerRadius: 8)
//								.foregroundStyle(.red)
//						}
//						.shadow(radius: 5)
//					}
//				}
				
				
				
			}
			.buttonStyle(.plain)
			Spacer()

		}
    }
}

#Preview {
	NavigationStack {
		Form {
			Section {
				UserProfileHeaderView()
					.withEnvironmentObjects(isUserAdmin: true)
			}
		}
	}
}
