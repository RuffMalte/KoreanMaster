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
	
    var body: some View {
		VStack(alignment: .leading) {
			Text(message.welcomeMessage)
				.font(.system(.headline, design: .rounded, weight: .bold))
			Text(message.translation)
				.font(.system(.subheadline, design: .monospaced, weight: .regular))
		}
		.contextMenu {
			Button {
				isShowingEditingSheet.toggle()
			} label: {
				Label("Edit", systemImage: "pencil")
			}
			Button {
				//TODO: implement delete
			} label: {
				Label("Delete", systemImage: "trash")
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
