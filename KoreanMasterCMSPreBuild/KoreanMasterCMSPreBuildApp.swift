//
//  KoreanMasterCMSPreBuildApp.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI
import Firebase


@main
struct KoreanMasterCMSPreBuildApp: App {
	
	init() {
		FirebaseApp.configure()
	}
	
	@StateObject var loginController = LoginController()
	@StateObject var coursesController = CoursesController()
	
    var body: some Scene {
        WindowGroup {
			if loginController.isInitialLoading {
				ProgressView()
			} else {
				if loginController.loggedIn {
					ContentView()
				} else {
					if loginController.isLoadingAccountSignIn {
						ProgressView()
					} else {
						LoginView(selectedLoginOption: loginController.loginOption)
					}
				}
			}
				
        }
		.environmentObject(coursesController)
		.environmentObject(loginController)

    }
}
