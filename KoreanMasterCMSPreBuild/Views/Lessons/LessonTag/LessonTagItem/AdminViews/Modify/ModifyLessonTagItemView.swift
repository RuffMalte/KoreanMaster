//
//  ModifyLessonTagItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 08.03.24.
//

import SwiftUI

struct ModifyLessonTagItemView: View {
	
	@State var tagItem: LessonTagItem
	
	var removeFuntion: () -> Void
	
		
	@FocusState private var isFocused: Bool
	
	
	
    var body: some View {
		HStack {
			
			TextField("", text: Binding<String>(
				get: {
					// Ensure the text always starts with "#"
					self.tagItem.tagName.hasPrefix("#") ? self.tagItem.tagName : "#\(self.tagItem.tagName)"
				},
				set: {
					// Remove the initial "#" if the user tries to delete it, and update the actual tag item.
					let newText = $0
					if newText.hasPrefix("#") {
						// If the new text starts with "#", use it as is.
						self.tagItem.tagName = newText
					} else if newText.isEmpty {
						// If all text is deleted, just set to "#"
						self.tagItem.tagName = "#"
					} else {
						// If there's text but no "#", add the "#" prefix.
						self.tagItem.tagName = "#\(newText)"
					}
				}
			))
			.focused($isFocused)
			.textFieldStyle(.plain)
			
				
			if isFocused {
				MaltesColorPicker(color: $tagItem.tagColor, colorPickerStyle: .menu)
				
				Button {
					removeFuntion()
				} label: {
					Image(systemName: "xmark")
				}
				.buttonStyle(.plain)
				
				Button {
					isFocused = false
				} label: {
					Image(systemName: "checkmark")
				}
				
			}
			
		}
		.font(.system(.footnote, design: .rounded, weight: .bold))
		.foregroundStyle(tagItem.tagColor.toColor)
		.padding(5)
		.background {
			RoundedRectangle(cornerRadius: 5)
				.foregroundStyle(tagItem.tagColor.toColor.opacity(0.2))
		}
		.contextMenu {
			RenameButton()
		}
    }
}

#Preview {
	ModifyLessonTagItemView(tagItem: LessonTagItem.multipleExamples[0], removeFuntion: { print("Hello?")})
}
