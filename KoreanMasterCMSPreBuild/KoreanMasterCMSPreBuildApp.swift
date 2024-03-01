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
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
