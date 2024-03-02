//
//  LoginController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import Foundation
import Observation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@Observable
class LoginController: ObservableObject {
	
	var loggedIn = false
	var isLoadingAccountSignIn: Bool = false
	var isInitialLoading: Bool = true
	var loginOption: LoginOptions = .login
	
	
	var user: User?
	
	var currentFirestoreUser: FirestoreUser?

	
	
	var allFirestoreUsers: [FirestoreUser] = []
	
	var allLanguages: [CourseLanguage] = []
	
	init() {
		self.checkUserLoggedIn()
		self.getAllLanguages()
		
	}
	
	//MARK: User for FirebaseAuth
	
	func checkUserLoggedIn() {
		Auth.auth().addStateDidChangeListener { auth, user in
			if user != nil {
				self.user = auth.currentUser
				self.readFirestoreUser()
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
				
				self.createFirestoreUser(displayName: displayName)
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
				self.readFirestoreUser()
				self.loggedIn = true
				self.isLoadingAccountSignIn = false

			}
		}
	}
	
	func deleteCurrentUser() {
		self.isLoadingAccountSignIn = true
		self.deleteFirestoreUser(with: self.user?.uid ?? "")
		
		Auth.auth().currentUser?.delete { error in
			if let error = error as NSError? {
				if error.code == AuthErrorCode.requiresRecentLogin.rawValue {
					self.loginOption = .reauthenticate
					self.loggedIn = false
				} else {
					print(error.localizedDescription)
				}
			} else {
				print("User deleted")

				self.loginOption = .create
				self.loggedIn = false
				print("User deleted")
			}
		}
		self.isLoadingAccountSignIn = false

	}
	
	func reauthenticateUser(email: String, password: String) {
		let user = Auth.auth().currentUser
		let credential = EmailAuthProvider.credential(withEmail: email, password: password)
		user?.reauthenticate(with: credential) { result, error in
			if let error = error {
				print(error)
			}
			self.deleteCurrentUser()
			//TODO: implement some kind of Confirmation
			self.loginOption = .create
			self.loggedIn = false
		}
		
	}
	
	//MARK: User for FireStore
	
	func createFirestoreUser(displayName: String? = nil) {
		guard let user = user else { return }
		
		let usersCollection = Firestore.firestore().collection("users")
		let newUser = FirestoreUser(id: user.uid, email: user.email ?? "", displayName: displayName ?? user.displayName ?? "")
		
		do {
			try usersCollection.document(user.uid).setData(from: newUser)
			self.currentFirestoreUser = newUser
		} catch {
			print("Error writing user to Firestore: \(error)")
		}
	}

	func readFirestoreUser() {
		guard let user = user else { return }
		
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(user.uid).getDocument { document, error in
			if let error = error {
				print("Error reading user from Firestore: \(error)")
			} else {
				if let document = document, document.exists {
					do {
						self.currentFirestoreUser = try document.data(as: FirestoreUser.self)
					} catch {
						print("Error decoding user from Firestore: \(error)")
					}
				} else {
					print("User does not exist")
				}
			}
		}
	}
	
	func deleteFirestoreUser(with id: String) {
		print("Deleting user from Firestore")
		
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(id).delete { error in
			if let error = error {
				print("Error deleting user from Firestore: \(error)")
			} else {
				self.currentFirestoreUser = nil
				print("User successfully deleted from Firestore.")
			}
		}
	}
	
	
	
	//MARK: Admin
	
	func getAllFirestoreUsers() {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.getDocuments { querySnapshot, error in
			if let error = error {
				print("Error reading all users from Firestore: \(error)")
			} else {
				self.allFirestoreUsers = querySnapshot?.documents.compactMap { document in
					try? document.data(as: FirestoreUser.self)
				} ?? []
			}
		}
	}
	
	func changeUserAdminStatus(with id: String) {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(id).getDocument { document, error in
			if let error = error {
				print("Error reading user from Firestore: \(error)")
			} else {
				if let document = document, document.exists {
					do {
						let user = try document.data(as: FirestoreUser.self)
						user.isAdmin.toggle()
						try usersCollection.document(id).setData(from: user)
					} catch {
						print("Error decoding user from Firestore: \(error)")
					}
				} else {
					print("User does not exist")
				}
			}
		}
	}
	
	func changeUserAdminLessonStatus(with id: String) {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(id).getDocument { document, error in
			if let error = error {
				print("Error reading user from Firestore: \(error)")
			} else {
				if let document = document, document.exists {
					do {
						let user = try document.data(as: FirestoreUser.self)
						user.isAdminLesson.toggle()
						try usersCollection.document(id).setData(from: user)
					} catch {
						print("Error decoding user from Firestore: \(error)")
					}
				} else {
					print("User does not exist")
				}
			}
		}
	}
	
	
	//MARK: Language selected to learn korean from
	
	func changeUserLanguageSelected(with id: String, language: String) {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(id).getDocument { document, error in
			if let error = error {
				print("Error reading user from Firestore: \(error)")
			} else {
				if let document = document, document.exists {
					do {
						let user = try document.data(as: FirestoreUser.self)
						user.languageSelected = language
						try usersCollection.document(id).setData(from: user)
					} catch {
						print("Error decoding user from Firestore: \(error)")
					}
				} else {
					print("User does not exist")
				}
			}
		}
	}
	
	func getAllLanguages() {
		let languagesCollection = Firestore.firestore().collection("languages")
		languagesCollection.getDocuments { querySnapshot, error in
			if let error = error {
				print("Error reading all languages from Firestore: \(error)")
			} else {
				self.allLanguages = querySnapshot?.documents.compactMap { document in
					try? document.data(as: CourseLanguage.self)
				} ?? []
			}
		}
	}
	
	func addLanguageToFirestore(language: CourseLanguage) {
		let languagesCollection = Firestore.firestore().collection("languages")
		
		do {
			try languagesCollection.document(language.language).setData(from: language)
		} catch {
			print("Error writing language to Firestore: \(error)")
		}
	}
	
	func editLanguageInFirestore(language: CourseLanguage) {
		let languagesCollection = Firestore.firestore().collection("languages")
		
		do {
			try languagesCollection.document(language.language).setData(from: language)
		} catch {
			print("Error writing language to Firestore: \(error)")
		}
	}
	
}
