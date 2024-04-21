//
//  LessonDifficultyControllerTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 21.03.24.
//

import XCTest

final class LessonDifficultyControllerTests: XCTestCase {

   var diffController: DifficultyController!
	
	override func setUp() {
		super.setUp()
		diffController = DifficultyController()
	}

	
	func testGetDifficultyForWordSuccess() {
		let creatExpectation = self.expectation(description: "create difficulty")
		let newDiff = LessonDiffuculty.example
		
		newDiff.id = "TEST"
		newDiff.difficulty = "TEST"
		diffController.saveDiffuculty(difficulty: newDiff, language: "English") { bool, error in
			XCTAssertNil(error)
			XCTAssertTrue(bool)
			creatExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getExpectation = self.expectation(description: "get difficulty")
		diffController.getDifficulties(with: ["TEST"], language: "English") { diff, error in
			XCTAssertNil(error)
			XCTAssertNotNil(diff)
			
			
			XCTAssertEqual(diff.count, 1)
			XCTAssertEqual(diff.first?.difficulty, "TEST")
			getExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let deleteExpectation = self.expectation(description: "delete difficulty")
		diffController.deleteDifficulties(with: ["TEST"], language: "English") { bool, error in
			XCTAssertNil(error)
			XCTAssertTrue(bool)
			deleteExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getAfterDeleteExpectation = self.expectation(description: "get difficulty after delete")
		diffController.getDifficulties(with: ["TEST"], language: "English") { diff, error in
			XCTAssertNil(error)
			XCTAssertNotNil(diff)
			
			XCTAssertEqual(diff.count, 0)
			getAfterDeleteExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
	}
	
}
