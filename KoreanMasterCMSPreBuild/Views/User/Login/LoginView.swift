//
//  LoginView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct LoginView: View {
	
	@State var selectedLoginOption: LoginOptions
	
	@State private var email: String = ""
	@State private var password: String = ""
	
	@State private var displayName: String = ""
	
	@State var selectedLessonInterfaceLanguage: String = "English"
	
	@EnvironmentObject var loginCon: LoginController

	
    var body: some View {
		Form {
			HStack {
				Spacer()
				Text(selectedLoginOption.localized)
					.font(.system(.largeTitle, design: .rounded, weight: .bold))
					.foregroundStyle(LinearGradient(colors: [.orange, .purple], startPoint: .top, endPoint: .bottom))
					.padding()
				Spacer()
			}
			
			Section {
				TextField("Email", text: $email)
				SecureField("Password", text: $password)
				
				switch selectedLoginOption {
				case .login:
					Button("Login") {
						loginCon.loginUser(email: email, password: password)
					}
					.disabled(email.isEmpty || password.isEmpty)
					Button("Forgot password") {
					}
					Button("Dont have an account? Create one!") {
						selectedLoginOption = .create
					}
				case .create:
					TextField("Display Name", text: $displayName)

					Button("Create Account") {
						loginCon.createUser(email: email, password: password, displayName: displayName)
					}
					.disabled(email.isEmpty || password.isEmpty || displayName.isEmpty)

					Button("Already have an account? Login!") {
						selectedLoginOption = .login
					}
				case .reauthenticate:
					Button("Reauthenticate") {
					}
				}
				
				
				
			}
			.textFieldStyle(.roundedBorder)
			.disableAutocorrection(true)
			.padding(.horizontal)
			
		}
		
    }
}

#Preview {
	LoginView(selectedLoginOption: .create)
}
