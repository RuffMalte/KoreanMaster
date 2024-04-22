//
//  KoreanMasterAppPreBuildApp.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI
import Firebase
import SwiftData

@main
struct KoreanMasterAppPreBuildApp: App {
	
	let container: ModelContainer
	
	init() {
		FirebaseApp.configure()
		
//		let settings = FirestoreSettings()
//		
//		// Use memory-only cache
//		settings.cacheSettings = MemoryCacheSettings(garbageCollectorSettings: MemoryLRUGCSettings())
//		
//		// Use persistent disk cache, with 100 MB cache size
//		settings.cacheSettings = PersistentCacheSettings(sizeBytes: 100 * 1024 * 1024 as NSNumber)
//		
//		// Enable offline data persistence
//		let db = Firestore.firestore()
//		db.settings = settings
//		
		
		let schema = Schema([
			UserLocalVocab.self
		])
		let config = ModelConfiguration("KoreanMasterAppPreBuildApp", schema: schema)
		do {
			container = try ModelContainer(for: schema, configurations: config)
		} catch {
			fatalError("Could not configure the container")
		}

		print(URL.applicationSupportDirectory.path(percentEncoded: false))
	}
	
	@StateObject var loginController = LoginController()
	@StateObject var coursesController = CoursesController()
	@StateObject var alertModal: AlertManager = AlertManager()

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
						LoginMainView(selectedLoginOption: loginController.loginOption)
					}
				}
			}
        }
		.modelContainer(container)
		.environmentObject(coursesController)
		.environmentObject(loginController)
		.environmentObject(alertModal)

    }
}
