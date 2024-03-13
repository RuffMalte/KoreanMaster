//
//  LocalizedWelcomeMessageListView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import SwiftUI

struct LocalizedWelcomeMessageListView: View {
	
	var language: String
	
	@EnvironmentObject var loginCon: LoginController

	@State var messages: [LocalizedWelcomeMessage] = []
	
	@State private var isShowingAddMessage: Bool = false
    var body: some View {
		
		VStack {
			if loginCon.isloadingMessages {
				ProgressView()
			} else {
				List {
					Text("Welcome Messages for \(language)")
					ForEach(messages) { message in
						WelcomeMessageDetailSmallCellView(message: message, currentLanguage: language)
					}
				}
			}
			
		}
		.navigationTitle("\(language) welcome messages")
		.onAppear {
			loginCon.getWelcomeMessages(language: language) { messages, error in
				guard error != nil else {
					self.messages = messages
					return
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					isShowingAddMessage.toggle()
				} label: {
					Label("Add new message", systemImage: "plus")
				}

			}
		}
		.sheet(isPresented: $isShowingAddMessage) {
			ModifyWelcomeMessageSheetView(message: LocalizedWelcomeMessage.empty, currentLanguage: language)
		}
    }
}

#Preview {
	LocalizedWelcomeMessageListView(language: "English")
}
