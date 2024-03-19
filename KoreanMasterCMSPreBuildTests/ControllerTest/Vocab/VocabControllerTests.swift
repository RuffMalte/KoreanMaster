//
//  VocabControllerTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 19.03.24.
//

import XCTest

final class VocabControllerTests: XCTestCase {

	var vocabController: VocabController!
	
	override func setUp() {
		super.setUp()
		vocabController = VocabController()
	}
	
	
	func testGetVocabForWordSuccess() {
		let creatExpectation = self.expectation(description: "create vocab")
		let newVocab = Vocab(id: "TEST", koreanVocab: "test", koreanSentence: "test", localizedVocab: "test", selectedLanguage: "test", partOfSpeech: "test", localizedSentence: "test", wikiUrl: "test")
		vocabController.saveVocab(vocab: newVocab, language: "English") { bool, error in
			XCTAssertNil(error)
			XCTAssertTrue(bool)
			creatExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getExpectation = self.expectation(description: "get vocab")
		vocabController.getVocab(with: ["TEST"], language: "English") { vocab, error in
			XCTAssertNil(error)
			XCTAssertNotNil(vocab)
			
			
			XCTAssertEqual(vocab.count, 1)
			XCTAssertEqual(vocab.first?.localizedVocab, "test")
			getExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		
		let deleteExpectation = self.expectation(description: "delete vocab")
		vocabController.deleteVocabs(with: ["TEST"], language: "English") { bool, error in
			XCTAssertNil(error)
			XCTAssertTrue(bool)
			deleteExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 20, handler: nil)
	}
}
