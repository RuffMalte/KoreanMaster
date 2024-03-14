//
//  ModifyWelcomeMessageSheetView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import SwiftUI

struct ModifyWelcomeMessageSheetView: View {

	@State var message: LocalizedWelcomeMessage
	var currentLanguage: String
	
	@EnvironmentObject private var loginCon: LoginController

	@Environment(\.dismiss) var dismiss
	
	@State private var isLoadingAddingMessage: Bool = false
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Text(message.id)
						.contextMenu {
							Button {
								PasteboardController().copyToPasteboard(string: message.id)
							} label: {
								Label("Copy", systemImage: "doc.on.doc")
									.labelStyle(.titleAndIcon)
							}
						}
					
					HStack {
						TextField("\(currentLanguage)", text: $message.inSelectedLanguage)
						Button {
							
						} label: {
							Label("Auto Translate", systemImage: "arrow.triangle.2.circlepath.circle")
						}
					}
					TextField("Korean", text: $message.inKorean)
				}
			}
			.textFieldStyle(.roundedBorder)
			.padding()
			.navigationTitle("Add new message")
			.toolbar {
				ToolbarItem(placement: .automatic) {
					Button {
						loginCon.saveWelcomeMessage(with: message, language: currentLanguage) { isFinished in
							print("Saved: \(isFinished)")
							isLoadingAddingMessage = !isFinished
						}
						dismiss()
					} label: {
						if isLoadingAddingMessage {
							ProgressView()
						} else {
							Label("Save", systemImage: "checkmark")
						}
					}
				}
				ToolbarItem(placement: .automatic) {
					Button(role: .cancel) {
						dismiss()
					} label: {
						Label("Cancel", systemImage: "xmark")
					}
				}
			}
			.navigationTitle("")
			
		}
    }
}

#Preview {
	ModifyWelcomeMessageSheetView(message: LocalizedWelcomeMessage.example, currentLanguage: "English")
}
