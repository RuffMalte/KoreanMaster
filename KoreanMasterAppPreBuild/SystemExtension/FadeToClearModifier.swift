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
	
	func body(content: Content) -> some View {
		content
			.foregroundStyle(
				LinearGradient(colors: [startColor, endColor], startPoint: startPoint, endPoint: endPoint)
			)
			.mask(
				LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)
			)
	}
}

extension View {
	func fadeToClear(startColor: Color, endColor: Color, startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) -> some View {
		self.modifier(FadeToClearModifier(startColor: startColor, endColor: endColor, startPoint: startPoint, endPoint: endPoint))
	}
}
