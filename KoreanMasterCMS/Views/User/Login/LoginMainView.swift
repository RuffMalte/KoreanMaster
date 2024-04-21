//
//  LoginMainView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 12.04.24.
//

import SwiftUI

struct LoginMainView: View {
	
	@State var selectedLoginOption: LoginOptions
	
	@State private var email: String = ""
	@State private var password: String = ""
	
	@State private var displayName: String = ""
	
	@State private var selectedLanguage: CourseLanguage?
	
	
	@EnvironmentObject var loginCon: LoginController
	
	
	@State private var showLoginOptions: LoginOptions = .login
	@State private var color: Color = .red
	
    var body: some View {
		NavigationStack {
			GeometryReader { geo in
				ScrollViewReader { proxy in
					ScrollView(.vertical, showsIndicators: false) {
						ZStack {
							VStack {
								Spacer()
								ZStack {
									Rectangle()
										.foregroundStyle(.bar)
									
									VStack(alignment: .leading) {
										HStack {
											Text("🇰🇷")
												.padding(.horizontal)
												.offset(y: -50)
												.font(.system(size: 70))
												.shadow(color: .gray, radius: 7, x: 0, y: 7)

											Spacer()
											
											
											Link(destination: URL(string: "https://unsplash.com/@thattravelblog?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash")!) {
												
												Image(systemName: "safari")
											}
											.padding()
											.offset(y: -60)
											.font(.headline)
											.foregroundStyle(.white)

										}
										Spacer()
									}
									VStack(spacing: 16) {
										Button {
											color = .red
											withAnimation {
												showLoginOptions = .login
												proxy.scrollTo(2)
											}
											
										} label: {
											HStack {
												Spacer()
												Text("Sign In")
													.font(.system(.headline, design: .rounded, weight: .bold))
													.foregroundStyle(.white)
												Spacer()
											}
										}
										.padding()
										.background {
											RoundedRectangle(cornerRadius: 16)
												.foregroundStyle(.red)
										}
										
										Button {
											color = .blue
											withAnimation {
												showLoginOptions = .create
												proxy.scrollTo(2)
											}
										} label: {
											HStack {
												Spacer()
												Text("Sign up")
													.font(.system(.headline, design: .rounded, weight: .bold))
													.foregroundStyle(.white)
												Spacer()
											}
										}
										.padding()
										.background {
											RoundedRectangle(cornerRadius: 16)
												.foregroundStyle(.blue)
										}
									}
									.padding(20)
								}
								.buttonStyle(.plain)
								.frame(width: geo.size.width, height: geo.size.height / 3)
							}
						}
						.frame(width: geo.size.width, height: geo.size.height)
						.background {
							Image("KoreaPic1")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: geo.size.width, height: geo.size.height)

						}
						.id(1)
						
						ZStack {
							VStack(spacing: 10) {
								TextField("E-mail", text: $email)
								SecureField("Password", text: $password)
								
								if showLoginOptions == .create {
									
									TextField("Display name", text: $displayName)
									
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
									
									
									Button {
										loginCon.createUser(email: email, password: password, displayName: displayName)
									} label: {
										Text("Create account")
											.foregroundStyle(.primary)
											.padding()
											.font(.headline)
											.background {
												RoundedRectangle(cornerRadius: 16)
													.foregroundStyle(.white)
											}
									}
									.padding()
									.disabled(email.isEmpty || password.isEmpty || selectedLanguage != nil)

								} else if showLoginOptions == .login {
									
									Button {
										loginCon.loginUser(email: email, password: password)
									} label: {
										Text("Login")
											.foregroundStyle(.primary)
											.padding()
											.font(.headline)
											.background {
												RoundedRectangle(cornerRadius: 16)
													.foregroundStyle(.white)
											}
									}
									.padding()
									.disabled(email.isEmpty || password.isEmpty)
									
									
									
								}
							}
							.textFieldStyle(.roundedBorder)
							.padding()
							
							VStack {
								Spacer()
								Button {
									withAnimation {
										proxy.scrollTo(1)
									}
								} label: {
									Label("Show login options", systemImage: "chevron.up")
										.font(.headline)
								}
								.padding(30)
							}
						}
						.buttonStyle(.plain)
						.frame(width: geo.size.width, height: geo.size.height)
						.background(color.opacity(0.8))
						.id(2)
						
					}
				}
			}
			.onAppear {
				if !loginCon.allLanguages.isEmpty {
					selectedLanguage = loginCon.allLanguages.first
				}
			}
			.ignoresSafeArea()
			#if os(iOS)
			.toolbarBackground(.hidden, for: .navigationBar)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					VStack(alignment: .leading) {
						Text("KoreanMaster")
							.font(.system(.largeTitle, design: .rounded, weight: .bold))
						Text("Learn the most important concepts")
							.font(.system(.subheadline, design: .default, weight: .bold))
					}
					.offset(y: 10)
					.foregroundStyle(.white)
				}
			}
			#elseif os(macOS)
			.navigationTitle("KoreanMaster")
			#endif
		}
    }
}

#Preview {
	var loginCon = LoginController()
	loginCon.allLanguages = CourseLanguage.listSampleData

	return LoginMainView(selectedLoginOption: .login)
		.environmentObject(loginCon)

}
