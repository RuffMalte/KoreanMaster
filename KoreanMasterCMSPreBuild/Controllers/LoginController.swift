//
//  LoginController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class LoginController: ObservableObject {
	
	@Published var loggedIn = false
	@Published var isLoadingAccountSignIn: Bool = false
	@Published var isInitialLoading: Bool = true
	@Published var loginOption: LoginOptions = .login
	
	
	@Published var user: User?

	
	init() {
		self.checkUserLoggedIn()
		
	}
	
	func checkUserLoggedIn() {
		Auth.auth().addStateDidChangeListener { auth, user in
			if user != nil {
				self.user = auth.currentUser
				
				self.loggedIn = true
			} else {
				self.loginOption = .create
				self.loggedIn = false
				
			}
			self.isInitialLoading = false
		}
	}
	
	func logoutUser() {
		do {
			try Auth.auth().signOut()
			self.loggedIn = false
		} catch {
			print(error)
		}
	}
	
	func createUser(email: String, password: String, displayName: String) {
		self.isLoadingAccountSignIn = true
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error)
			} else {
				self.changeUserDisplayName(displayName: displayName)
				
				
				
				self.loggedIn = true
				self.isLoadingAccountSignIn = false
			}
		}
	}
	
	func changeUserDisplayName(displayName: String) {
		let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
		changeRequest?.displayName = displayName
		changeRequest?.commitChanges { error in
			if let error = error {
				print(error)
			}
		}
	}
	

	func loginUser(email: String, password: String) {
		self.loginOption = .login
		self.isLoadingAccountSignIn = true
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error)
			} else {
				self.loggedIn = true
				self.isLoadingAccountSignIn = false

			}
		}
	}
	
	func deleteCurrentUser() {
		
		Auth.auth().currentUser?.delete { error in
			if let error = error {
				print(error)
			} else {
				self.loginOption = .create
				self.loggedIn = false
			}
		}
	}
	
	
	
}
