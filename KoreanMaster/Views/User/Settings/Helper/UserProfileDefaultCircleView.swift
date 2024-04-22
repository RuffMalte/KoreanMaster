//
//  UserProfileDefaultCircleView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI

struct UserProfileDefaultCircleView: View {
	@EnvironmentObject var loginCon: LoginController

    var body: some View {
		Circle()
			.frame(width: 100, height: 100)
			.shadow(radius: 5)
			.foregroundStyle(.tint.opacity(0.75))
			.overlay {
				if let currentFirestoreUser = loginCon.currentFirestoreUser {
					Text(currentFirestoreUser.displayName.prefix(1))
						.font(.system(.title, design: .rounded, weight: .bold))
				}
			}
    }
}

#Preview {
    UserProfileDefaultCircleView()
}
