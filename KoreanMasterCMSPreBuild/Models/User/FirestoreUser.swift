//
//  FirestoreUser.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import Foundation

class FirestoreUser: Identifiable, Encodable, Decodable {
	var id: String
	var email: String
	var displayName: String
	var isAdmin: Bool
	var isAdminLesson: Bool
	
	init(id: String, email: String, displayName: String, isAdmin: Bool = false, isAdminLesson: Bool = false) {
		self.id = id
		self.email = email
		self.displayName = displayName
		self.isAdmin = isAdmin
		self.isAdminLesson = isAdminLesson
	}
}
