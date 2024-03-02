//
//  ModifyLanguageSheetView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct ModifyLanguageSheetView: View {
	
	var language: CourseLanguage?
	
	@EnvironmentObject var loginCon: LoginController
	@Environment(\.dismiss) var dismiss
	
	@State private var workingLanguage: CourseLanguage = CourseLanguage.emtpyCourseLanguage
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Language", text: $workingLanguage.language)
					TextField("Language Code", text: $workingLanguage.languageCode)
					TextField("Language Flag", text: $workingLanguage.languageFlag)
				}
			}
			.navigationTitle(language == nil ? "Add Language" : "Modify Language")
			.onAppear {
				if let language = language {
					workingLanguage = language
				}
			}
			
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						if let language = language {
							loginCon.addLanguageToFirestore(language: workingLanguage)
						} else {
							loginCon.editLanguageInFirestore(language: workingLanguage)
						}
						dismiss()
					} label: {
						Text(language == nil ? "Add" : "Save")
					}
				}
				ToolbarItem(placement: .automatic) {
					Button(role: .cancel) {
						dismiss()
					} label: {
						Text("Cancel")
					}
				}
			}
		}
    }
}

#Preview {
	ModifyLanguageSheetView(language: CourseLanguage.simpleExample)
}
