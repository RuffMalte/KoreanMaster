//
//  FadeToClearModifier.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 27.03.24.
//

import SwiftUI

struct FadeToClearModifier: ViewModifier {
	var startColor: Color
	var endColor: Color
	var startPoint: UnitPoint
	var endPoint: UnitPoint
	var height: CGFloat? = nil
	func body(content: Content) -> some View {
		content
			.frame(maxHeight: height) // Constrain content height if desired
									  // Apply the color gradient behind the content
			.background(
				LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: startPoint, endPoint: endPoint)
			)
		// Overlay the fade-to-clear effect
			.mask( // Mask both content and background gradient with a fade-to-clear effect
				VStack(spacing: 0) {
					LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
						.frame(height: height) // Apply fade effect within the specified height
				}
			)
	}
}

extension View {
	func fadeToClear(startColor: Color, endColor: Color, startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing, height: CGFloat? = nil) -> some View {
		self.modifier(FadeToClearModifier(startColor: startColor, endColor: endColor, startPoint: startPoint, endPoint: endPoint, height: height))
	}
}
