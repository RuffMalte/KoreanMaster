//
//  TranslationControllerTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 19.03.24.
//

import XCTest

final class TranslationControllerTests: XCTestCase {

	var translationController: TranslationController!
	
	override func setUp() {
		super.setUp()
		translationController = TranslationController()
	}
	
	func testEnglishToSpanishTranslationSuccess() {
		let textToTranslate = "Hello"
		let expectedTranslation = "안녕하세요"
		let targetLang = "KO"
		
		let expectation = self.expectation(description: "TranslationSuccess")
		
		translationController.getTranslation(for: textToTranslate, targetLang: targetLang) { translation, error in
			XCTAssertNil(error, "There was an unexpected error during translation: \(error!.localizedDescription)")
			XCTAssertEqual(translation, expectedTranslation, "The translation does not match the expected value.")
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 10, handler: nil)
	}

}
