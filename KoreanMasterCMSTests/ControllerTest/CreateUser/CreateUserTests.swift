//
//  CreateUserTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 20.03.24.
//

import XCTest

final class CreateUserTests: XCTestCase {

	var loginController: LoginController!

	override func setUp() {
		super.setUp()
		loginController = LoginController()
	}
	
	
	func testCreateUser() {
		let createExpectation = self.expectation(description: "create user")
		let testFireStoreUser: FirestoreUser = FirestoreUser(id: "TestID", email: "email2", displayName: "displayname", isAdmin: true, isAdminLesson: true, languageSelected: "English")
		
		//MARK: creating
		loginController.createFirestoreUser(preselectedUser: testFireStoreUser) { isFinished, error in
			XCTAssertTrue(isFinished, "User creation should be finished.")
			XCTAssertNil(error, "Error should be nil.")
			createExpectation.fulfill()

		}
		waitForExpectations(timeout: 20, handler: nil)

		
		
		let getExpectation = self.expectation(description: "get user")
		loginController.readFirestoreUser(with: testFireStoreUser.id) { user, bool, error in
			XCTAssertNil(error, "Error should be nil.")
			XCTAssertEqual(bool, true, "Bool should be true.")
			XCTAssertNotNil(user, "User should not be nil.")
			
			XCTAssertEqual(user?.id, testFireStoreUser.id, "User id should be equal.")
			XCTAssertEqual(user?.email, testFireStoreUser.email, "User email should be equal.")
			XCTAssertEqual(user?.displayName, testFireStoreUser.displayName, "User displayName should be equal.")
			XCTAssertEqual(user?.isAdmin, testFireStoreUser.isAdmin, "User isAdmin should be equal.")
			XCTAssertEqual(user?.isAdminLesson, testFireStoreUser.isAdminLesson, "User isAdminLesson should be equal.")
			XCTAssertEqual(user?.languageSelected, testFireStoreUser.languageSelected, "User languageSelected should be equal.")
			
			
			getExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		
		
		
		//MARK: Admin Update
		let updateAdminExpectation = self.expectation(description: "update user admin status")
		loginController.changeUserAdminStatus(with: testFireStoreUser.id) { bool, error in
			XCTAssertNil(error, "Error should be nil.")
			XCTAssertEqual(bool, true, "Bool should be true.")
			updateAdminExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		
		let updateLessonAdminExpectation = self.expectation(description: "update user lesson admin status")
		loginController.changeUserAdminLessonStatus(with: testFireStoreUser.id) { bool, error in
			XCTAssertNil(error, "Error should be nil.")
			XCTAssertEqual(bool, true, "Bool should be true.")
			updateLessonAdminExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		let adminStatusExpectation = self.expectation(description: "check user admin status")
		loginController.readFirestoreUser(with: testFireStoreUser.id) { user, bool, error in
			XCTAssertNil(error, "Error should be nil.")
			XCTAssertEqual(bool, true, "Bool should be true.")
			XCTAssertNotNil(user, "User should not be nil.")
			
			XCTAssertEqual(user?.id, testFireStoreUser.id, "User id should be equal.")
			XCTAssertEqual(user?.email, testFireStoreUser.email, "User email should be equal.")
			XCTAssertEqual(user?.displayName, testFireStoreUser.displayName, "User displayName should be equal.")
			XCTAssertEqual(user?.isAdmin, !testFireStoreUser.isAdmin, "User isAdmin should be equal.")
			XCTAssertEqual(user?.isAdminLesson, !testFireStoreUser.isAdminLesson, "User isAdminLesson should be equal.")
			XCTAssertEqual(user?.languageSelected, testFireStoreUser.languageSelected, "User languageSelected should be equal.")
			
			
			adminStatusExpectation.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
		
		
		//MARK: Deletion
		let deleteExpectation = self.expectation(description: "delete user")
		loginController.deleteFirestoreUser(with: testFireStoreUser.id) { isFinished, error in
			XCTAssertTrue(isFinished, "User deletion should be finished.")
			XCTAssertNil(error, "Error should be nil.")
			deleteExpectation.fulfill()
		}
		
		waitForExpectations(timeout: 20, handler: nil)
		
		let getExpectation2 = self.expectation(description: "get user should be nil")
		loginController.readFirestoreUser(with: testFireStoreUser.id) { user, bool, error in
			XCTAssertNil(error, "Error should be nil.")
			XCTAssertEqual(bool, false, "Bool should be false.")
			XCTAssertNil(user, "User should be nil.")
			
			getExpectation2.fulfill()
		}
		waitForExpectations(timeout: 20, handler: nil)
		
	}

}
