//
//  LocalizedWelcomeMessageMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 13.03.24.
//

import SwiftUI

extension LocalizedWelcomeMessage {
	static let example = LocalizedWelcomeMessage(welcomeMessage: "코리안마스터에 오신 것을 환영합니다!", translation: "Welcome to KoreanMaster!")
	
	static let empty = LocalizedWelcomeMessage(welcomeMessage: "", translation: "")
}
