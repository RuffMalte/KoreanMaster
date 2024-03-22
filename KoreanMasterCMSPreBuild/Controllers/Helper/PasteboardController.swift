//
//  PasteboardController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI


class PasteboardController {
	
	
	#if os(iOS)
	
	func copyToPasteboard(string: String) {
		UIPasteboard.general.string = string
	}
	
	#elseif os(macOS)
	
	func copyToPasteboard(string: String) {
		let pasteboard = NSPasteboard.general
		pasteboard.clearContents()
		pasteboard.setString(string, forType: .string)
	}
	
	
	
	#endif
	
	
}
