//
//  KoreanMasterAppPreBuildApp.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI
import Firebase

@main
struct KoreanMasterAppPreBuildApp: App {
	
	init() {
		FirebaseApp.configure()
		
		let settings = FirestoreSettings()
		
		// Use memory-only cache
		settings.cacheSettings = MemoryCacheSettings(garbageCollectorSettings: MemoryLRUGCSettings())
		
		// Use persistent disk cache, with 100 MB cache size
		settings.cacheSettings = PersistentCacheSettings(sizeBytes: 100 * 1024 * 1024 as NSNumber)
		
		// Enable offline data persistence
		let db = Firestore.firestore()
		db.settings = settings
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
