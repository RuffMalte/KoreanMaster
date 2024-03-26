//
//  ContentView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

import Firebase

struct ContentView: View {
	
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .red
	
    var body: some View {
        MainTabView()
			.tint(selectedTintColor.toColor)
    }
}

#Preview {
	ContentView()
		.withEnvironmentObjects()
}
