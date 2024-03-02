//
//  UserCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct UserCellView: View {
	
	@State var user: FirestoreUser
	
	@EnvironmentObject var loginCon: LoginController
	
    var body: some View {
		
		VStack {
			HStack {
				Text(user.displayName)
					.font(.system(.headline, design: .rounded, weight: .bold))
				Spacer()
				
				if user.isAdmin {
					Image(systemName: "star.fill")
						.foregroundStyle(.yellow)
				}
				if user.isAdminLesson {
					Image(systemName: "graduationcap.fill")
						.foregroundStyle(.green)
				}
			}
			
			HStack {
				Text(user.email)
					
				Spacer()
				
				Text(user.id)
					
			}
			.font(.system(.footnote, design: .monospaced, weight: .medium))
			.font(.footnote)
		}
		.contextMenu {
			
			Button {
				PasteboardController().copyToPasteboard(string: user.id)
			} label: {
				Label("Copy ID", systemImage: "doc.on.doc.fill")
			}
			.labelStyle(.titleAndIcon)

			Divider()
			
			Button {
				loginCon.changeUserAdminStatus(with: user.id)
			} label: {
				Label("Change admin status", systemImage: user.isAdmin ? "star.slash.fill" : "star.fill")
					.foregroundStyle(.yellow)
			}
			.labelStyle(.titleAndIcon)

			Button {
				loginCon.changeUserAdminLessonStatus(with: user.id)
			} label: {
				Label("Change Lesson admin status", systemImage: user.isAdminLesson ? "graduationcap" : "graduationcap.fill")
					.foregroundStyle(.green)
			}
			.labelStyle(.titleAndIcon)
		}
		
		
			
		
    }
}

#Preview {
	UserCellView(user: FirestoreUser.singleExample)
}
