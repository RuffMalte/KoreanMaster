//
//  CourseControllerTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 20.03.24.
//

import XCTest

final class CourseControllerTests: XCTestCase {

	var courseController: CoursesController!
	
	override func setUp() {
		super.setUp()
		courseController = CoursesController()
	}
	
	func testGetCoursesSuccess() {
		let creatExpectation = self.expectation(description: "create course")
		let newLesson = Lesson.detailExample
		newLesson.id = "TEST"
		newLesson.lessonInfo.lessonName = "TEST"
		
		courseController.SaveLesson(lesson: newLesson, language: "English") { bool in
			XCTAssertTrue(bool)
			creatExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getExpectation = self.expectation(description: "get course")
		courseController.getFullLesson(lessonID: newLesson.lessonInfo.lessonName, language: "English") { lesson, error in
			XCTAssertNil(error)
			XCTAssertNotNil(lesson)
			XCTAssertEqual(lesson?.lessonInfo.lessonName, "TEST")
			
			XCTAssertNotNil(lesson?.lessonInfo.lessonName)
			
			XCTAssertNotNil(lesson?.lessonTag)
			XCTAssertNotNil(lesson?.lessonTag.lessonTagItems)
			
			XCTAssertNotNil(lesson?.lessonGoal?.lessonGoalExamples)
			
			XCTAssertNotNil(lesson?.newLessonVocabUsed)
			
			XCTAssertNotNil(lesson?.lessonGrammar?.LessonGrammarPages)
			
			XCTAssertNotNil(lesson?.lessonPractice?.mulitpleChoice)
			XCTAssertNotNil(lesson?.lessonPractice?.sentenceBuilding)
			
			XCTAssertNotNil(lesson?.lessonCultureReferences?.songs)
			
			getExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let deleteExpectation = self.expectation(description: "delete course")
		courseController.deleteLesson(lesson: newLesson, language: "English") { bool in
			XCTAssertTrue(bool)
			deleteExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		let getExpectation2 = self.expectation(description: "get course")
		courseController.getFullLesson(lessonID: newLesson.lessonInfo.lessonName, language: "English") { lesson, error in
			XCTAssertNotNil(lesson)
			XCTAssertNil(error)
			getExpectation2.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
	}
	
}
