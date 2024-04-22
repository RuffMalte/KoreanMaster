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
		
		let settings = FirestoreSettings()
		
		// Use memory-only cache
		settings.cacheSettings =
		MemoryCacheSettings(garbageCollectorSettings: MemoryLRUGCSettings())
		
		// Use persistent disk cache, with 100 MB cache size
		settings.cacheSettings = PersistentCacheSettings(sizeBytes: 100 * 1024 * 1024 as NSNumber)
		
		// Enable offline data persistence
		let db = Firestore.firestore()
		db.settings = settings
	}
	
	@StateObject var loginController = LoginController()
	@StateObject var coursesController = CoursesController()
	@StateObject var alertModal: AlertManager = AlertManager()

    var body: some Scene {
		Group {
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
							LoginMainView(selectedLoginOption: loginController.loginOption)
						}
					}
				}
				
			}
		}
		.environmentObject(coursesController)
		.environmentObject(loginController)
		.environmentObject(alertModal)

    }
}
