//
//  DocumentRefrenceGeneratorTests.swift
//  KoreanMasterCMSPreBuildTests
//
//  Created by Malte Ruff on 23.03.24.
//

import XCTest

final class DocumentRefrenceGeneratorTests: XCTestCase {

	var documentRefrenceGenerator: DocumentReferenceGenerator!
	
	override func setUp() {
		super.setUp()
		documentRefrenceGenerator = DocumentReferenceGenerator(lessonID: "TestLesson", language: "TestLanguage")
	}
	
	func testInitialization() {
		XCTAssertEqual(documentRefrenceGenerator.language, "TestLanguage", "Language should be set to 'TestLanguage'.")
		XCTAssertNotNil(documentRefrenceGenerator.lessonID, "lessonID should not be initially nil.")
	}

	
	func testMainPaths() {
		XCTAssertEqual(documentRefrenceGenerator.mainPath, "lessonData/TestLanguage", "Main path should match the specified language.")
		XCTAssertEqual(documentRefrenceGenerator.welcomeMessagePath, "lessonData/TestLanguage/welcomeMessage", "Welcome message path should match the specified language.")
		XCTAssertEqual(documentRefrenceGenerator.vocabPath, "lessonData/TestLanguage/vocab", "Vocab path should match the specified language.")
		XCTAssertEqual(documentRefrenceGenerator.difficultyPath, "lessonData/TestLanguage/difficulty", "Difficulty path should match the specified language.")
	}


	func testGetLessonsCollectionRef() {
		let collectionRef = documentRefrenceGenerator.getLessonsCollectionRef()
		XCTAssertEqual(collectionRef.path, "lessonData/TestLanguage/lessons", "Collection path should be correctly formed based on the language.")
	}

	
	func testGetDocumentRef() {
		let docRef = documentRefrenceGenerator.getDocumentRef(forType: .info)
		XCTAssertEqual(docRef.path, "lessonData/TestLanguage/lessons/TestLesson/details/info", "Document reference path should be correctly formed.")
		
		let docRef1 = documentRefrenceGenerator.getDocumentRef(forType: .tags)
		XCTAssertEqual(docRef1.path, "lessonData/TestLanguage/lessons/TestLesson/details/tags", "Document reference path should be correctly formed.")
		
		let docRef2 = documentRefrenceGenerator.getDocumentRef(forType: .goal)
		XCTAssertEqual(docRef2.path, "lessonData/TestLanguage/lessons/TestLesson/details/goal", "Document reference path should be correctly formed.")
		
		let docRef3 = documentRefrenceGenerator.getDocumentRef(forType: .vocabUsed)
		XCTAssertEqual(docRef3.path, "lessonData/TestLanguage/lessons/TestLesson/details/vocabUsed", "Document reference path should be correctly formed.")
		
		let docRef4 = documentRefrenceGenerator.getDocumentRef(forType: .grammar)
		XCTAssertEqual(docRef4.path, "lessonData/TestLanguage/lessons/TestLesson/details/grammar", "Document reference path should be correctly formed.")
		
		let docRef5 = documentRefrenceGenerator.getDocumentRef(forType: .practice)
		XCTAssertEqual(docRef5.path, "lessonData/TestLanguage/lessons/TestLesson/details/practice", "Document reference path should be correctly formed.")
		
		let docRef6 = documentRefrenceGenerator.getDocumentRef(forType: .cultureReferences)
		XCTAssertEqual(docRef6.path, "lessonData/TestLanguage/lessons/TestLesson/details/cultureReferences", "Document reference path should be correctly formed.")
	}
	
	func testSubCollectionRef() {
		let collectionRef = documentRefrenceGenerator.getCollectionRef(forDetail: .goal, subCollection: .goalsExamples)
		XCTAssertEqual(collectionRef.path, "lessonData/TestLanguage/lessons/TestLesson/details/goal/goalsExamples", "Collection path should be correctly formed.")
		
		let collectionRef1 = documentRefrenceGenerator.getCollectionRef(forDetail: .grammar, subCollection: .grammarPages)
		XCTAssertEqual(collectionRef1.path, "lessonData/TestLanguage/lessons/TestLesson/details/grammar/grammarPages", "Collection path should be correctly formed.")
		
		let collectionRef2 = documentRefrenceGenerator.getCollectionRef(forDetail: .practice, subCollection: .practiceMultipleChoice)
		XCTAssertEqual(collectionRef2.path, "lessonData/TestLanguage/lessons/TestLesson/details/practice/multipleChoice", "Collection path should be correctly formed.")
		
		let collectionRef3 = documentRefrenceGenerator.getCollectionRef(forDetail: .practice, subCollection: .practiceSentenceBuilding)
		XCTAssertEqual(collectionRef3.path, "lessonData/TestLanguage/lessons/TestLesson/details/practice/sentenceBuild", "Collection path should be correctly formed.")
		
		let collectionRef4 = documentRefrenceGenerator.getCollectionRef(forDetail: .cultureReferences, subCollection: .cultureSongs)
		XCTAssertEqual(collectionRef4.path, "lessonData/TestLanguage/lessons/TestLesson/details/cultureReferences/songs", "Collection path should be correctly formed.")
	}

	func testGetWelcomeMessagesRef() {
		let collectionRef = documentRefrenceGenerator.getWelcomeMessagesRef()
		XCTAssertEqual(collectionRef.path, "lessonData/TestLanguage/welcomeMessage", "Welcome messages collection path should be correctly formed.")
	}
	
	func testGetDocWelcomeMessageRef() {
		let docRef = documentRefrenceGenerator.getDocWelcomeMessageRef(withId: "welcome1")
		XCTAssertEqual(docRef.path, "lessonData/TestLanguage/welcomeMessage/welcome1", "Welcome message document path should be correctly formed.")
	}

	func testGetVocabCollectionRef() {
		let collectionRef = documentRefrenceGenerator.getVocabCollectionRef()
		XCTAssertEqual(collectionRef.path, "lessonData/TestLanguage/vocab", "Vocabulary collection path should be correctly formed.")
	}
	
	func testGetVocabDocRef() {
		let docRef = documentRefrenceGenerator.getVocabDocRef(withId: "vocab1")
		XCTAssertEqual(docRef.path, "lessonData/TestLanguage/vocab/vocab1", "Vocabulary document path should be correctly formed.")
	}
	
	func testGetDifficultyCollectionPath() {
		let collectionRef = documentRefrenceGenerator.getDifficultyCollectionPath()
		XCTAssertEqual(collectionRef.path, "lessonData/TestLanguage/difficulty", "Difficulty collection path should be correctly formed.")
	}
	
	func testGetDifficultyDocRef() {
		let docRef = documentRefrenceGenerator.getDifficultyDocRef(withId: "easy")
		XCTAssertEqual(docRef.path, "lessonData/TestLanguage/difficulty/easy", "Difficulty document path should be correctly formed.")
	}
}
