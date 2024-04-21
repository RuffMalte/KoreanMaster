//
//  ColorExtension.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 24.03.24.
//

import SwiftUI

//https://stackoverflow.com/questions/60672626/swiftui-get-the-dynamic-background-color-dark-mode-or-light-mode
public extension Color {
	
#if os(macOS)
	static let background = Color(NSColor.windowBackgroundColor)
	static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
	static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
#else
	static let background = Color(UIColor.systemBackground)
	static let secondaryBackground = Color(UIColor.secondarySystemBackground)
	static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
#endif
}
