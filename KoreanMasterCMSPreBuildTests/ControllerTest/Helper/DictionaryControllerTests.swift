//
//  DictionaryControllerTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 19.03.24.
//

import XCTest

final class DictionaryControllerTests: XCTestCase {

	var dictionaryController: DictionaryController!
	
	override func setUp() {
		super.setUp()
		dictionaryController = DictionaryController()
	}
	
	
	func testGetDictForWordSuccess() {
		let word = "apple"
		let expectation = self.expectation(description: "GetDictForWordSuccess")
		
		dictionaryController.getDictForWord(word: word) { dictionary, error in
			XCTAssertNil(error, "There was an unexpected error during dictionary lookup: \(error!.localizedDescription)")
			XCTAssertNotNil(dictionary, "The dictionary should not be nil.")
			XCTAssertEqual(dictionary?.word, word, "The dictionary word does not match the expected value.")
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 10, handler: nil)
	}

}
