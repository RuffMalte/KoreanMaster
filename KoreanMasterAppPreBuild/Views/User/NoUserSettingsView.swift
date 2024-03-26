//
//  NoUserSettingsView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

struct NoUserSettingsView: View {
    var body: some View {
		Group {
			ContentUnavailableView(label: {
				Label("No User", systemImage: "person.fill.questionmark")
			}, description: {
				Text("How did you get here 🤨?")
			}, actions: {
				Button {
					
				} label: {
					Label("Sign Up", systemImage: "person.fill.badge.plus")
				}
				.buttonStyle(.borderedProminent)
				Button {
					
				} label: {
					Label("Log In", systemImage: "person.fill")
				}
				.buttonStyle(.bordered)
			})
		}
    }
}

#Preview {
    NoUserSettingsView()
}
