//
//  ContentView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct ContentView: View {
	
	@AppStorage("selectedTintColor") var selectedTintColor: ColorEnum = .blue
	
    var body: some View {
        MainTabView()
			.tint(selectedTintColor.toColor)
    }
}

#Preview {
    ContentView()
}
