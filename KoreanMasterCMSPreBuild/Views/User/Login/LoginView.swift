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
	@State private var selectedLanguage: CourseLanguage?
	
	
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
				Button {
					email = "1@1.com"
					password = "123456"
					displayName = "TestUser "
				} label: {
					Label("Fill in Debug 1", systemImage: "arrow.right.circle.fill")
						.foregroundStyle(.red)
				}
				
				Button {
					email = "2@2.com"
					password = "123456"
					displayName = "TestUser 2"
				} label: {
					Label("Fill in Debug 2", systemImage: "arrow.right.circle.fill")
						.foregroundStyle(.blue)

				}
				
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
					
					if let selectedLang = selectedLanguage {
						Menu {
							ForEach(loginCon.allLanguages) { lang in
								Button {
									selectedLanguage = lang
								} label: {
									Label {
										Text(lang.language)
									} icon: {
										Text(lang.languageFlag)
									}
								}
							}
							
							
						} label: {
							Label {
								Text(selectedLang.language)
							} icon: {
								Text(selectedLang.languageFlag)
							}
							
						}
					}
						
					
					Button("Create Account") {
						loginCon.createUser(email: email, password: password, displayName: displayName)
					}
					.disabled(email.isEmpty || password.isEmpty || displayName.isEmpty)
					.onAppear {
						if !loginCon.allLanguages.isEmpty {
							selectedLanguage = loginCon.allLanguages.first
						} 
					}
					Button("Already have an account? Login!") {
						selectedLoginOption = .login
					}
				case .reauthenticate:
					Button("Reauthenticate") {
						loginCon.reauthenticateUser(email: email, password: password)
					}
					.disabled(email.isEmpty || password.isEmpty)
				}
				
				
				
			}
			.textFieldStyle(.roundedBorder)
			.disableAutocorrection(true)
			.padding(.horizontal)
			
		}
		
    }
}

#Preview {
	var loginCon = LoginController()
	
	return LoginView(selectedLoginOption: .create)
		.environmentObject(loginCon)
}
