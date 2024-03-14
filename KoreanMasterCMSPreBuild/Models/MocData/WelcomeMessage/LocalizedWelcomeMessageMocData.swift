//
//  LocalizedWelcomeMessageMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import SwiftUI

extension LocalizedWelcomeMessage {
	static let example = LocalizedWelcomeMessage(
		id: "example",
		inSelectedLanguage: "Welcome to Korean Master",
		inKorean: "한국어 마스터에 오신 것을 환영합니다"
	)
	
	static let empty = LocalizedWelcomeMessage(
		inSelectedLanguage: "",
		inKorean: ""
	)
}
