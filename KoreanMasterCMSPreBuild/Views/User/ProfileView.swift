//
//  ProfileView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import SwiftUI

struct ProfileView: View {
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		Form {
			Section(header: Text("Account")) {
				Text("Username: Malte")
				Text("Email: ")
				
			}
			
		}
		.toolbar {
			ToolbarItem(placement: .automatic) {
				Button(role: .cancel) {
					dismiss()
				} label: {
					Text("Close")
				}
			}
		}
    }
}

#Preview {
    ProfileView()
}
