//
//  Lesson.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 05.03.24.
//

import Foundation

class AllLessonsLocalized: Codable {
	
	var localizedLessons: [LocalizedLessons]
	
	init(
		localizedLessons: [LocalizedLessons]
	) {
		self.localizedLessons = localizedLessons
	}
}

class LocalizedLessons: Identifiable, Codable {
	var language: String
	var info: String
	
	
	var lessons: [Lesson]
	
	init(
		language: String,
		info: String,
		lessons: [Lesson]
	) {
		self.language = language
		self.info = info
		self.lessons = lessons
	}
	
}


class Lesson: Identifiable, Codable {
	
	var id: String
	
	
	var lessonInfo: LessonInfo?
	var lessonGoal: LessonGoal?
	
	var newLessonVocabUsed: [NewLessonVocabUsed]?
	var lessonGrammer: LessonGrammer?
	var lessonPratice: LessonPratice?
	var lessonCultureReferences: [LessonCultureReference]?
	
	init(
		id: String = UUID().uuidString,
		lessonInfo: LessonInfo? = nil,
		lessonGoal: LessonGoal? = nil,
		newLessonVocabUsed: [NewLessonVocabUsed]? = nil,
		lessonGrammer: LessonGrammer? = nil,
		lessonPratice: LessonPratice? = nil,
		lessonCultureReferences: [LessonCultureReference]? = nil
	) {
		self.id = id
		self.lessonInfo = lessonInfo
		self.lessonGoal = lessonGoal
		self.newLessonVocabUsed = newLessonVocabUsed
		self.lessonGrammer = lessonGrammer
		self.lessonPratice = lessonPratice
		self.lessonCultureReferences = lessonCultureReferences
	}
	
	
}

class LessonInfo: Identifiable, Codable {
	var section: Int
	var unit: Int
	
	var lessonName: String
	var heading: String
	var desc: String
	var difficulty: String
	var xpToGain: Int
	
	var lessonTags: [LessonTag]
	
	var likedBy: [LikedBy]?
	var commentedBy: [CommentedBy]?
	
	init(
		section: Int,
		unit: Int,
		lessonName: String,
		heading: String,
		desc: String,
		difficulty: String,
		xpToGain: Int,
		lessonTags: [LessonTag],
		likedBy: [LikedBy]? = nil,
		commentedBy: [CommentedBy]? = nil
	) {
		self.section = section
		self.unit = unit
		self.lessonName = lessonName
		self.heading = heading
		self.desc = desc
		self.difficulty = difficulty
		self.xpToGain = xpToGain
		self.lessonTags = lessonTags
		self.likedBy = likedBy
		self.commentedBy = commentedBy
	}
}

class LessonTag: Identifiable, Codable {
	var id: String
	var tagName: String
	var tagColor: String
	
	init(
		id: String = UUID().uuidString,
		tagName: String,
		tagColor: String
	) {
		self.id = id
		self.tagName = tagName
		self.tagColor = tagColor
	}
}

class LikedBy: Identifiable, Codable {
	var id: String
	var byUserID: String
	var name: String
	var profilePicURL: String
	
	init(
		id: String = UUID().uuidString,
		byUserID: String,
		name: String,
		profilePicURL: String
	) {
		self.id = id
		self.byUserID = byUserID
		self.name = name
		self.profilePicURL = profilePicURL
	}
}

class CommentedBy: Identifiable, Codable {
	var id: String
	var comment: String
	var byUserID: String
	var userName: String
	var likes: [LikedBy]
	
	init(
		id: String = UUID().uuidString,
		comment: String,
		byUserID: String,
		userName: String,
		likes: [LikedBy]
	) {
		self.id = id
		self.comment = comment
		self.byUserID = byUserID
		self.userName = userName
		self.likes = likes
	}
}

class LessonGoal: Identifiable, Codable {
	var goalText: String
	var title: String
	
	var lessonGoalExamples: [LessonGoalExample]
	
	init(
		goalText: String,
		title: String,
		lessonGoalExamples: [LessonGoalExample]
	) {
		self.goalText = goalText
		self.title = title
		self.lessonGoalExamples = lessonGoalExamples
	}
}

class LessonGoalExample: Identifiable, Codable {
	var id: String
	var title: String
	var koreanText: String
	var translatedText: String
	
	init(
		id: String = UUID().uuidString,
		title: String,
		koreanText: String,
		translatedText: String
	) {
		self.id = id
		self.title = title
		self.koreanText = koreanText
		self.translatedText = translatedText
	}
}

class NewLessonVocabUsed: Identifiable, Codable {
	var id: String
	var vocabID: String
	var vocabKorean: String
	var vocabTranslation: String
	var vocabType: String
	
	init(
		id: String = UUID().uuidString,
		vocabID: String,
		vocabKorean: String,
		vocabTranslation: String,
		vocabType: String
	) {
		self.id = id
		self.vocabID = vocabID
		self.vocabKorean = vocabKorean
		self.vocabTranslation = vocabTranslation
		self.vocabType = vocabType
	}
	
}

class LessonGrammer: Identifiable, Codable {
	var title: String
	var desc: String
	
	var lessonGrammerPages: [LessonGrammerPage]
	
	init(
		title: String,
		desc: String,
		lessonGrammerPages: [LessonGrammerPage]
	) {
		self.title = title
		self.desc = desc
		self.lessonGrammerPages = lessonGrammerPages
	}
}

class LessonGrammerPage: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	var example: String
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
		example: String
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.example = example
	}
}

class LessonPratice: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	
	var mulitpleChoice: [LessonPraticeMultipleChoice]
	var sentenceBuilding: [LessonPraticeSentenceBuilding]
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
		mulitpleChoice: [LessonPraticeMultipleChoice],
		sentenceBuilding: [LessonPraticeSentenceBuilding]
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.mulitpleChoice = mulitpleChoice
		self.sentenceBuilding = sentenceBuilding
	}
}

class LessonPraticeMultipleChoice: Identifiable, Codable {
	var id: String
	var question: String
	var answers: [String]
	var correctAnswer: String
	
	init(
		id: String = UUID().uuidString,
		question: String,
		answers: [String],
		correctAnswer: String
	) {
		self.id = id
		self.question = question
		self.answers = answers
		self.correctAnswer = correctAnswer
	}
}

class LessonPraticeSentenceBuilding: Identifiable, Codable {
	var id: String
	var question: String
	var answers: [String]
	var correctAnswer: String
	
	init(
		id: String = UUID().uuidString,
		question: String,
		answers: [String],
		correctAnswer: String
	) {
		self.id = id
		self.question = question
		self.answers = answers
		self.correctAnswer = correctAnswer
	}
}

class LessonCultureReference: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	var image: String
	var link: String
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
		image: String,
		link: String
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.image = image
		self.link = link
	}
}
