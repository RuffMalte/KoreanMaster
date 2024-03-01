//
//  LoginOptions.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 01.03.24.
//

import Foundation


enum LoginOptions: String, CaseIterable {
	case login
	case create
	case reauthenticate
	
	
	var localized: String {
		switch self {
		case .login:
			return "Login"
		case .create:
			return "Create Account"
		case .reauthenticate:
			return "Reauthenticate"
		}
		
	}
}
