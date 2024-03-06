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
		lessonGoal: LessonGoal.example,
		newLessonVocabUsed: NewLessonVocabUsed.multipleExample,
		lessonGrammer: LessonGrammer.example,
		lessonPratice: LessonPratice.example,
		lessonCultureReferences: LessonCultureReference.multipleExample
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
		lessonTags: LessonTag.multipleExample,
		likedBy: LikedBy.multipleExample,
		commentedBy: CommentedBy.multipleExample
	)
}

extension LessonTag {
	static var example: LessonTag = LessonTag(
		tagName: "Alphabet",
		tagColor: "blue"
	)
	
	static var multipleExample: [LessonTag] = [
		LessonTag(tagName: "Tag 1", tagColor: "green"),
		LessonTag(tagName: "Tag 2", tagColor: "red"),
		LessonTag(tagName: "Tag 3", tagColor: "blue"),
		LessonTag(tagName: "Tag 4", tagColor: "yellow")
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
	static var multipleExample: [NewLessonVocabUsed] = [
		NewLessonVocabUsed(vocabID: "123", vocabKorean: "aa", vocabTranslation: "aw", vocabType: "awd"),
		NewLessonVocabUsed(vocabID: "123", vocabKorean: "aa", vocabTranslation: "aw", vocabType: "awd"),
		NewLessonVocabUsed(vocabID: "123", vocabKorean: "aa", vocabTranslation: "aw", vocabType: "awd"),
		NewLessonVocabUsed(vocabID: "123", vocabKorean: "aa", vocabTranslation: "aw", vocabType: "awd")
	]
}

extension LessonGrammer {
	static var example: LessonGrammer = LessonGrammer(
		title: "Title",
		desc: "desc",
		lessonGrammerPages: LessonGrammerPage.multipleExample
	)
	
}

extension LessonGrammerPage {
	static var multipleExample: [LessonGrammerPage] = [
		LessonGrammerPage(title: "Title 1", desc: "desc", example: "example"),
		LessonGrammerPage(title: "Title 2", desc: "desc", example: "example"),
		LessonGrammerPage(title: "Title 3", desc: "desc", example: "example")
	]
}

extension LessonPratice {
	static var example: LessonPratice = LessonPratice(
		title: "Lesson Pratice example",
		desc: "desc",
		mulitpleChoice: LessonPraticeMultipleChoice.multipleExample,
		sentenceBuilding: LessonPraticeSentenceBuilding.multipleExample
	)
}

extension LessonPraticeMultipleChoice {
	static var multipleExample: [LessonPraticeMultipleChoice] = [
		LessonPraticeMultipleChoice(question: "question", answers: ["a", "b"], correctAnswer: "a"),
		LessonPraticeMultipleChoice(question: "question", answers: ["a", "b"], correctAnswer: "a"),
		LessonPraticeMultipleChoice(question: "question", answers: ["a", "b"], correctAnswer: "a")
	]
}

extension LessonPraticeSentenceBuilding {
	static var multipleExample: [LessonPraticeSentenceBuilding] = [
		LessonPraticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a"),
		LessonPraticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a"),
		LessonPraticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a"),
		LessonPraticeSentenceBuilding(question: "adawdw", answers: ["a", "b"], correctAnswer: "a")
	]
}

extension LessonCultureReference {
	static var multipleExample: [LessonCultureReference] = [
		LessonCultureReference(title: "Title", desc: "desc", image: "image", link: "link"),
		LessonCultureReference(title: "Title", desc: "desc", image: "image", link: "link"),
		LessonCultureReference(title: "Title", desc: "desc", image: "image", link: "link"),
		LessonCultureReference(title: "Title", desc: "desc", image: "image", link: "link")
	]
}
