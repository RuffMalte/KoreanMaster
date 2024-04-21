//
//  WelcomeMessagesControllerTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 20.03.24.
//

import XCTest

final class WelcomeMessagesControllerTests: XCTestCase {

	var loginController: LoginController!

	override func setUp() {
		super.setUp()
		loginController = LoginController()
	}
	
	
	func testWelcomeMessages() {
		let newWelcomeMessage = LocalizedWelcomeMessage(id: "TEST", inSelectedLanguage: "English", inKorean: "TEST")
		
		let saveExpectation = self.expectation(description: "save welcome message")
		loginController.saveWelcomeMessage(with: newWelcomeMessage, language: "English") { bool in
			XCTAssertTrue(bool)
			saveExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getExpectation = self.expectation(description: "get welcome message")
		loginController.getWelcomeMessages(language: "English", ids: ["TEST"]) { WelcomeMessages, error in
			XCTAssertNil(error)
			XCTAssertNotNil(WelcomeMessages)
			
			
			XCTAssertEqual(WelcomeMessages.count, 1)
			XCTAssertEqual(WelcomeMessages.first?.inKorean, "TEST")
			getExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let deleteExpectation = self.expectation(description: "delete welcome message")
		loginController.deleteWelcomeMessage(with: newWelcomeMessage, language: "English") { bool in
			XCTAssertTrue(bool)
			deleteExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getExpectation2 = self.expectation(description: "get welcome message")
		loginController.getWelcomeMessages(language: "English", ids: ["TEST"]) { WelcomeMessages, error in
			XCTAssertNil(error)
			XCTAssertEqual(WelcomeMessages.count, 0)
			getExpectation2.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
	}
	
}
