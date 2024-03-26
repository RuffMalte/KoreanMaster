//
//  WithEnviromentObjects.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct WithEnvironmentObjects: ViewModifier {
	
	
	init(isUserAdmin: Bool? = nil) {
		let newLoginCon = LoginController()
		newLoginCon.currentFirestoreUser = FirestoreUser(id: UUID().uuidString, email: "email@email.cpm", displayName: "Malte", isAdmin: isUserAdmin ?? false, isAdminLesson: isUserAdmin ?? false, languageSelected: "English")

		
		
		self.loginController = newLoginCon
	}
	
	var loginController = LoginController()
	var coursesController = CoursesController()
	
	func body(content: Content) -> some View {
		content
			.environment(loginController)
			.environment(coursesController)
	}
}

// Extend View to include the custom modifier for easier use
extension View {
	func withEnvironmentObjects(isUserAdmin: Bool? = nil) -> some View {
		self.modifier(WithEnvironmentObjects())
	}
}
