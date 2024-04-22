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
	
	
	var isloadingMessages: Bool = false
	
	var user: User?
	
	var currentFirestoreUser: FirestoreUser?

	
	
	var allFirestoreUsers: [FirestoreUser] = []
	
	var allLanguages: [CourseLanguage] = []
	
	init() {
		self.getAllLanguages() { languages in
			self.allLanguages = languages
			
			self.checkUserLoggedIn()
		}
	}
	
	//MARK: User for FirebaseAuth
	
	func checkUserLoggedIn() {
		Auth.auth().addStateDidChangeListener { auth, user in
			if user != nil {
				self.user = auth.currentUser
				self.readFirestoreUser { user, bool, error in
					if let error = error {
						print(error)
					}
					if let user = user {
						self.currentFirestoreUser = user
					}
						
				}
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
				
				self.createFirestoreUser(displayName: displayName) { isFinished, error in
					//TODO: Handle error
				}
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
		if let user = self.user {
			self.changeFirebaseDisplayName(withId: user.uid, displayName: displayName) { displayName, error in
				if let error = error {
					print(error)
				} else if let displayName = displayName {
					self.currentFirestoreUser?.displayName = displayName
				}
			}
		}
	}

	func loginUser(email: String, password: String) {
		self.loginOption = .login
		self.isLoadingAccountSignIn = true
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error)
				self.loginOption = .login
				self.isLoadingAccountSignIn = false
			} else {
				self.readFirestoreUser { user, bool, error in
					if let error = error {
						print(error)
					}
					if let user = user {
						self.currentFirestoreUser = user
					}
				}
				self.loggedIn = true
				self.isLoadingAccountSignIn = false

			}
		}
	}
	
	func deleteCurrentUser() {
		self.isLoadingAccountSignIn = true
		guard let user = user else { return }
		self.deleteFirestoreUser(with: user.uid) { bool, error in
			if let error = error {
				print(error)
			}
		}
		
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
	
	func createFirestoreUser(displayName: String? = nil, preselectedUser: FirestoreUser? = nil, completion: @escaping (Bool, Error?) -> Void) {
		let usersCollection = Firestore.firestore().collection("users")
		
		do {
			if let preselectedUser = preselectedUser {
				try usersCollection.document(preselectedUser.id).setData(from: preselectedUser) { error in
					if let error = error {
						completion(false, error)
					} else {
						self.currentFirestoreUser = preselectedUser
						completion(true, nil)
					}
				}
			} else {
				guard let user = user else { return }
				let newUser = FirestoreUser(id: user.uid, email: user.email ?? "", displayName: displayName ?? user.displayName ?? "")
				try usersCollection.document(newUser.id).setData(from: newUser) { error in
					if let error = error {
						completion(false, error)
					} else {
						self.currentFirestoreUser = newUser
						completion(true, nil)
					}
				}
			}
		} catch {
			completion(false, error)
		}
	}

	func readFirestoreUser(with id: String? = nil, completion: @escaping (FirestoreUser?, Bool, Error?) -> Void) {
		let usersCollection = Firestore.firestore().collection("users")
		
		if id == nil {
			guard user != nil else { return }
		}
		
		usersCollection.document(id != nil ? id! : user!.uid.description).getDocument { document, error in
			if let error = error {
				completion(nil, false, error)
			} else {
				if let document = document, document.exists {
					do {
						let fetchedFirestoreUser = try document.data(as: FirestoreUser.self)
						completion(fetchedFirestoreUser, true, nil)
					} catch {
						print("Error decoding user from Firestore: \(error)")
						completion(nil, false, error)
					}
				} else {
					self.logoutUser()
					print("User does not exist")
					completion(nil, false, nil)
				}
			}
		}
	}
	
	func deleteFirestoreUser(with id: String, completion: @escaping (Bool, Error?) -> Void) {
		guard !id.isEmpty else { return }
		
		let usersCollection = Firestore.firestore().collection("users")
		
		
		usersCollection.document(id).delete { error in
			if let error = error {
				completion(false, error)
			} else {
				self.currentFirestoreUser = nil
				completion(true, nil)
			}
		}
	}
	
	func changeFirebaseDisplayName(withId: String, displayName: String, completion: @escaping (String?, Error?) -> Void) {
		let usersCollection = Firestore.firestore().collection("users")
		
		usersCollection.document(withId).updateData(["displayName": displayName]) { error in
			if let error = error {
				print("Error updating user: \(error)")
				completion(nil, error)
			}
			completion(displayName, nil)
		}
		completion(nil, nil)
	}
	
	
	//MARK: Admin
	
	func getAllFirestoreUsers(with ids: [String]? = nil) {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.getDocuments { querySnapshot, error in
			if let error = error {
				print("Error reading all users from Firestore: \(error)")
			} else {
				var users: [FirestoreUser] = []
				let documents = querySnapshot?.documents ?? []
				
				for document in documents {
					if let user = try? document.data(as: FirestoreUser.self) {
						// If 'ids' is nil or empty, add all users. Otherwise, only add users whose ID is in 'ids'.
						if ids == nil || ids!.isEmpty || ids!.contains(user.id) {
							users.append(user)
						}
					}
				}
				
				self.allFirestoreUsers = users
			}
		}
	}

	
	func changeUserAdminStatus(with id: String, completion: @escaping (Bool, Error?) -> Void) {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(id).getDocument { document, error in
			if let error = error {
				completion(false, error)
			} else {
				if let document = document, document.exists {
					do {
						let user = try document.data(as: FirestoreUser.self)
						user.isAdmin.toggle()
						try usersCollection.document(id).setData(from: user)
						completion(true, nil)
					} catch {
						completion(false, error)
					}
				} else {
					completion(false, nil)
				}
			}
		}
	}
	
	func changeUserAdminLessonStatus(with id: String, completion: @escaping (Bool, Error?) -> Void) {
		let usersCollection = Firestore.firestore().collection("users")
		usersCollection.document(id).getDocument { document, error in
			if let error = error {
				completion(false, error)
			} else {
				if let document = document, document.exists {
					do {
						let user = try document.data(as: FirestoreUser.self)
						user.isAdminLesson.toggle()
						try usersCollection.document(id).setData(from: user)
						completion(true, nil)
					} catch {
						completion(false, error)
					}
				} else {
					completion(false, nil)
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
	
	func getAllLanguages(completion: @escaping ([CourseLanguage]) -> Void) {
		let languagesCollection = Firestore.firestore().collection("languages")
		languagesCollection.getDocuments { querySnapshot, error in
			if let error = error {
				print("Error reading all languages from Firestore: \(error)")
			} else {
				let allLanguages = querySnapshot?.documents.compactMap { document in
					try? document.data(as: CourseLanguage.self)
				} ?? []
				completion(allLanguages)
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
	
	
	//MARK: Welcome Messages
	func saveWelcomeMessage(with message: LocalizedWelcomeMessage, language: String, completion: @escaping (Bool) -> Void) {
		
		let db = Firestore.firestore()
		let batch = db.batch()
		let refGenerator = DocumentReferenceGenerator(language: language)

		
		let messageRef = refGenerator.getDocWelcomeMessageRef(withId: message.id)
		
		do {
			try batch.setData(from: message, forDocument: messageRef)
			
			// Finally, commit the batch
			batch.commit { error in
				if let error = error {
					print("Error writing batch to Firestore: \(error)")
					completion(false)
				} else {
					completion(true)
				}
			}
			
		} catch {
			print("Error writing message to Firestore: \(error)")
			completion(false)
		}
	}
	
	func getWelcomeMessages(language: String, ids: [String]? = nil, completion: @escaping ([LocalizedWelcomeMessage], Error?) -> Void) {
		let refGenerator = DocumentReferenceGenerator(language: language)
		let welcomeMessageRefGen = refGenerator.getWelcomeMessagesRef()
		self.isloadingMessages = true
		
		welcomeMessageRefGen.getDocuments { querySnapshot, error in
			var messages: [LocalizedWelcomeMessage] = []
			let dispatchGroup = DispatchGroup()
			
			if let snapshot = querySnapshot {
				for document in snapshot.documents {
					dispatchGroup.enter()
					do {
						let message = try document.data(as: LocalizedWelcomeMessage.self)
						// Check if the ids array is nil or empty, or if it contains the message's id
						if ids == nil || ids!.isEmpty || ids!.contains(message.id) {
							messages.append(message)
						}
						dispatchGroup.leave()
					} catch {
						print("Error decoding welcome message from Firestore: \(error)")
						dispatchGroup.leave()
					}
				}
				
				dispatchGroup.notify(queue: .main) {
					completion(messages, nil)
					self.isloadingMessages = false
				}
				
			} else if let error = error {
				completion([], error)
			}
			
		}
		
	}

	func deleteWelcomeMessage(with message: LocalizedWelcomeMessage, language: String, completion: @escaping (Bool) -> Void) {
		let refGenerator = DocumentReferenceGenerator(language: language)
		let messageRef = refGenerator.getDocWelcomeMessageRef(withId: message.id)
		
		messageRef.delete { error in
			if let error = error {
				print("Error deleting message from Firestore: \(error)")
				completion(false)
			} else {
				completion(true)
			}
		}
	}
}
