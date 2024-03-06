//
//  AllLessonsLocalizedMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 06.03.24.
//

import Foundation

extension AllLessonsLocalized {
	static var detailExample: AllLessonsLocalized = AllLessonsLocalized(localizedLessons: [
		LocalizedLessons.singleEnglishExample,
		LocalizedLessons.singleGermanExample
	])
}

extension LocalizedLessons {
	static var singleEnglishExample: LocalizedLessons = LocalizedLessons(
		language: "English",
		info: "The Korean lessons will be presented in english",
		lessons: [
			Lesson.detailExample
		]
	)
	static var singleGermanExample: LocalizedLessons = LocalizedLessons(
		language: "German",
		info: "Die Koreanisch Lektionen werden auf Deutsch präsentiert",
		lessons: [
			
		]
	)
}

extension Lesson {
	static var detailExample: Lesson = Lesson(
		id: "0",
		lessonInfo: LessonInfo.detailExample,
		lessonTags: LessonTag.example,
		lessonGoal: LessonGoal.example,
		newLessonVocabUsed: NewLessonVocabUsed.example,
		lessonGrammar: LessonGrammar.example,
		lessonPractice: Lessonpractice.example,
		lessonCultureReferences: LessonCultureReference.example
	)
}

extension LessonInfo {
	static var detailExample: LessonInfo = LessonInfo(
		section: 1,
		unit: 1,
		lessonName: "Lesson 1",
		heading: "The Korean Alphabet",
		desc: "Learn the Korean Alphabet",
		difficulty: "Easy",
		xpToGain: 100,
		likedBy: LikedBy.multipleExample,
		commentedBy: CommentedBy.multipleExample
	)
}

extension LessonTag {
	static var example: LessonTag = LessonTag(title: "Title", lessonTagItems: LessonTagItem.multipleExamples)
}

extension LessonTagItem {
	static var multipleExamples: [LessonTagItem] = [
		LessonTagItem(tagName: "Tag", tagColor: "green"),
		LessonTagItem(tagName: "Tag", tagColor: "green"),
		LessonTagItem(tagName: "Tag", tagColor: "green"),
		LessonTagItem(tagName: "Tag", tagColor: "green"),
		LessonTagItem(tagName: "Tag", tagColor: "green"),
		LessonTagItem(tagName: "Tag", tagColor: "green")
	]
}

extension LikedBy {
	static var multipleExample: [LikedBy] = [
		LikedBy(byUserID: "123123123123", name: "Name 1", profilePicURL: "https://www.google.com"),
		LikedBy(byUserID: "123123123123", name: "Name 2", profilePicURL: "https://www.google.com"),
		LikedBy(byUserID: "123123123123", name: "Name 3", profilePicURL: "https://www.google.com"),
		LikedBy(byUserID: "123123123123", name: "Name 4", profilePicURL: "https://www.google.com"),
	]
}

extension CommentedBy {
	static var multipleExample: [CommentedBy] = [
		CommentedBy(comment: "Hello World", byUserID: "123123", userName: "Name 1", likes: LikedBy.multipleExample),
		CommentedBy(comment: "Hello World", byUserID: "123123", userName: "Name 2", likes: LikedBy.multipleExample),
		CommentedBy(comment: "Hello World", byUserID: "123123", userName: "Name 3", likes: LikedBy.multipleExample)
	]
}

extension LessonGoal {
	static var example: LessonGoal = LessonGoal(
		goalText: "Goal Text",
		title: "TITLEEEE",
		lessonGoalExamples: LessonGoalExample.mutlipleExample
	)
}

extension LessonGoalExample {
	static var mutlipleExample: [LessonGoalExample] = [
		LessonGoalExample(title: "Title", koreanText: "ko text 1", translatedText: "org text 1"),
		LessonGoalExample(title: "Title", koreanText: "ko text 2", translatedText: "org text 2"),
		LessonGoalExample(title: "Title", koreanText: "ko text 3", translatedText: "org text 3")
	]
}

extension NewLessonVocabUsed {
	static var example: NewLessonVocabUsed = NewLessonVocabUsed(title: "Title", helpText: "helptext", vocabIDs: ["String"])
}

extension LessonGrammar {
	static var example: LessonGrammar = LessonGrammar(
		title: "Title",
		desc: "desc",
		LessonGrammarPages: LessonGrammarPage.multipleExample
	)
	
}

extension LessonGrammarPage {
	static var multipleExample: [LessonGrammarPage] = [
		LessonGrammarPage(title: "Title 1", desc: "desc", example: "example"),
		LessonGrammarPage(title: "Title 2", desc: "desc", example: "example"),
		LessonGrammarPage(title: "Title 3", desc: "desc", example: "example")
	]
}

extension Lessonpractice {
	static var example: Lessonpractice = Lessonpractice(
		title: "Lesson practice example",
		desc: "desc",
		mulitpleChoice: LessonpracticeMultipleChoice.multipleExample,
		sentenceBuilding: LessonpracticeSentenceBuilding.multipleExample
	)
}

extension LessonpracticeMultipleChoice {
	static var multipleExample: [LessonpracticeMultipleChoice] = [
		LessonpracticeMultipleChoice(question: "question", answers: ["a", "b"], correctAnswer: "a"),
		LessonpracticeMultipleChoice(question: "question", answers: ["a", "b"], correctAnswer: "a"),
		LessonpracticeMultipleChoice(question: "question", answers: ["a", "b"], correctAnswer: "a")
	]
}

extension LessonpracticeSentenceBuilding {
	static var multipleExample: [LessonpracticeSentenceBuilding] = [
		LessonpracticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a"),
		LessonpracticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a"),
		LessonpracticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a"),
		LessonpracticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a")
	]
}

extension LessonCultureReference {
	static var example: LessonCultureReference = LessonCultureReference(
		title: "Title",
		desc: "desc",
		songs: LessonCultureReferenceSongs.multipleExample
	)
}


extension LessonCultureReferenceSongs {
	static var multipleExample: [LessonCultureReferenceSongs] = [
		LessonCultureReferenceSongs(title: "AA", desc: "awd", image: "awd", link: "adw"),
		LessonCultureReferenceSongs(title: "AA", desc: "awd", image: "awd", link: "adw"),
		LessonCultureReferenceSongs(title: "AA", desc: "awd", image: "awd", link: "adw"),
		LessonCultureReferenceSongs(title: "AA", desc: "awd", image: "awd", link: "adw")
	
	]
}