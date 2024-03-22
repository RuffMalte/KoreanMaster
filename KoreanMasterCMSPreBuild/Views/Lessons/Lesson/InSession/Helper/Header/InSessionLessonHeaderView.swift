//
//  InSessionLessonHeader.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct InSessionLessonHeaderView<Content: View>: View {
	let title: String
	let subtitle: String
	let content: Content
	
	init(title: String, subtitle: String, @ViewBuilder content: () -> Content) {
		self.title = title
		self.subtitle = subtitle
		self.content = content()
	}
	
	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text(title)
						.font(.system(.title, design: .rounded, weight: .bold))
					
					Text(subtitle)
						.font(.system(.body, design: .rounded, weight: .regular))
						.foregroundStyle(.secondary)
				}
				Spacer()
			}
			
			Spacer()
			
			content
			
			Spacer()
		}
	}
	
}
