//
//  Haptics.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 26.03.24.
//

import SwiftUI

func playFeedbackHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
	@AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true

	if hapticsEnabled {
		let generator = UIImpactFeedbackGenerator(style: style)
		generator.impactOccurred()
	}
}


func playNotificationHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
	@AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true
	
	if hapticsEnabled {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(type)
	}
}
