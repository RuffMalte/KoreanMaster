//
//  NavLinkHeaderView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 17.03.24.
//

import SwiftUI

struct NavLinkHeaderView: View {
	
	var headerText: String
	var headerSFIcon: String
	
	var count: Int
	
    var body: some View {
		HStack {
			Label(headerText, systemImage: headerSFIcon)
			
			Spacer()
			Label(count.description, systemImage: "number")
				.font(.system(.headline, design: .monospaced, weight: .regular))
			
			Image(systemName: "chevron.right")
		}
		.font(.system(.headline, design: .rounded, weight: .bold))
    }
}

#Preview {
	NavLinkHeaderView(headerText: "Header", headerSFIcon: "book.fill", count: 0)
}
