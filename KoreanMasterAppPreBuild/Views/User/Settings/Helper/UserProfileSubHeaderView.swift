//
//  UserProfileSubHeaderView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI

struct UserProfileSubHeaderView<Content: View>: View {
	
	let title: String
	let content: Content
	
	init(title: String, @ViewBuilder content: () -> Content) {
		self.title = title
		self.content = content()
	}
	
    var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text(title)
						.font(.system(.title2, design: .rounded, weight: .bold))
				}
				Spacer()
			}
			
			Spacer()
			
			content
			
			Spacer()
		}
    }
}

#Preview {
	UserProfileSubHeaderView(title: "Title", content: {
		Text("Content")
	})
}

