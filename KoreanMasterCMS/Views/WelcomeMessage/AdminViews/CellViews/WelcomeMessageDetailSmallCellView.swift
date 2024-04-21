//
//  WelcomeMessageDetailSmallCellView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import SwiftUI

struct WelcomeMessageDetailSmallCellView: View {
	
	@State var message: LocalizedWelcomeMessage
	var currentLanguage: String
	@State private var isShowingEditingSheet = false
	
	@EnvironmentObject var loginCon: LoginController

    var body: some View {
		VStack(alignment: .leading) {
			Text(message.inSelectedLanguage)
				.font(.system(.headline, design: .rounded, weight: .bold))
			Text(message.inKorean)
				.font(.system(.subheadline, design: .monospaced, weight: .regular))
		}
		.contextMenu {
			Button {
				isShowingEditingSheet.toggle()
			} label: {
				Label("Edit", systemImage: "pencil")
					.labelStyle(.titleAndIcon)
			}
			Button {
				loginCon.deleteWelcomeMessage(with: message, language: currentLanguage) { isFinished in
					print("Deleted: \(isFinished)")
				}
			} label: {
				Label("Delete", systemImage: "trash")
					.labelStyle(.titleAndIcon)
					.foregroundStyle(.red)
			}
		}
		.sheet(isPresented: $isShowingEditingSheet) {
			ModifyWelcomeMessageSheetView(message: message, currentLanguage: currentLanguage)
		}
	}
}

#Preview {
	WelcomeMessageDetailSmallCellView(message: LocalizedWelcomeMessage.example, currentLanguage: "English")
}
