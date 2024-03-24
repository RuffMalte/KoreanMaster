//
//  Lesson.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 05.03.24.
//

import Foundation
import Observation

class AllLessonsLocalized: Codable {
	
	var localizedLessons: [LocalizedLessons]
	
	init(
		localizedLessons: [LocalizedLessons]
	) {
		self.localizedLessons = localizedLessons
	}
}

class LocalizedLessons: Identifiable, Codable {
	var id: String
	var language: String
	var info: String
	
	
	var lessons: [Lesson]
	
	init(
		id: String = UUID().uuidString,
		language: String,
		info: String,
		lessons: [Lesson]
	) {
		self.id = id
		self.language = language
		self.info = info
		self.lessons = lessons
	}
	
	func sortLessons() -> [Lesson] {
		return lessons.sorted { $0.lessonInfo.section > $1.lessonInfo.section && $0.lessonInfo.unit >
			$1.lessonInfo.unit }
	}
	
	func getSortedSection() -> [Int: [Lesson]] {
		var sortedSection: [Int: [Lesson]] = [:]
		for lesson in lessons {
			if sortedSection[lesson.lessonInfo.section] == nil {
				sortedSection[lesson.lessonInfo.section] = [lesson]
			} else {
				sortedSection[lesson.lessonInfo.section]?.append(lesson)
			}
		}
		return sortedSection
	}
}

@Observable
class Lesson: Identifiable, Codable {
	
	var id: String
	
	
	var lessonInfo: LessonInfo
	var lessonTag: LessonTag

	var lessonGoal: LessonGoal?
	
	var newLessonVocabUsed: NewLessonVocabUsed?
	var lessonGrammar: LessonGrammar?
	var lessonPractice: LessonPractice?
	var lessonCultureReferences: LessonCultureReference?
	
	init(
		id: String = UUID().uuidString,
		lessonInfo: LessonInfo,
		lessonTags: LessonTag,
		lessonGoal: LessonGoal? = nil,
		newLessonVocabUsed: NewLessonVocabUsed? = nil,
		lessonGrammar: LessonGrammar? = nil,
		lessonPractice: LessonPractice? = nil,
		lessonCultureReferences: LessonCultureReference? = nil
	) {
		self.id = id
		self.lessonInfo = lessonInfo
		self.lessonTag = lessonTags
		self.lessonGoal = lessonGoal
		self.newLessonVocabUsed = newLessonVocabUsed
		self.lessonGrammar = lessonGrammar
		self.lessonPractice = lessonPractice
		self.lessonCultureReferences = lessonCultureReferences
	}
	
	
}

@Observable
class LessonInfo: Identifiable, Codable {
	var section: Int
	var unit: Int
	
	var lessonName: String
	var heading: String
	var desc: String
	var difficultyID: String
	var xpToGain: Int
	
	var icon: String
	var color: ColorEnum
	
	var likedBy: [LikedBy]?
	var commentedBy: [CommentedBy]?
	
	init(
		section: Int,
		unit: Int,
		lessonName: String,
		heading: String,
		desc: String,
		difficultyID: String,
		xpToGain: Int,
		icon: String,
		color: ColorEnum,
		likedBy: [LikedBy]? = nil,
		commentedBy: [CommentedBy]? = nil
	) {
		self.section = section
		self.unit = unit
		self.lessonName = lessonName
		self.heading = heading
		self.desc = desc
		self.difficultyID = difficultyID
		self.xpToGain = xpToGain
		self.icon = icon
		self.color = color
		self.likedBy = likedBy
		self.commentedBy = commentedBy
	}
	
	func getSectionUnit() -> String {
		return "\(section) - \(unit)"
	}
	
	func toFirebase() -> [String: Any] {
		return [
			"_section": section,
			"_unit": unit,
			"_lessonName": lessonName,
			"_heading": heading,
			"_desc": desc,
			"_difficultyID": difficultyID,
			"_xpToGain": xpToGain,
			"_icon": icon,
			"_color": color.rawValue,
		]
	}}


@Observable
class LessonDiffuculty: Identifiable, Codable, Hashable {
	
	static func == (lhs: LessonDiffuculty, rhs: LessonDiffuculty) -> Bool {
		return lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	

	
	var id: String
	var difficulty: String
	var color: ColorEnum
	var SFicon: String
	
	init(
		id: String = UUID().uuidString,
		difficulty: String,
		color: ColorEnum = .blue,
		SFicon: String = "circle"
	) {
		self.id = id
		self.difficulty = difficulty
		self.color = color
		self.SFicon = SFicon
	}
}

@Observable
class LessonTag: Identifiable, Codable {
	var title: String
	var lessonTagItems: [LessonTagItem]?
	
	init(
		title: String,
		lessonTagItems: [LessonTagItem] = []
	) {
		self.title = title
		self.lessonTagItems = lessonTagItems
	}
}

@Observable
class LessonTagItem: Codable, Identifiable {
	var id: String
	var tagName: String
	var tagColor: ColorEnum
	
	init(
		id: String = UUID().uuidString,
		tagName: String,
		tagColor: ColorEnum
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

@Observable
class LessonGoal: Identifiable, Codable {
	var goalText: String
	var title: String
	
	var lessonGoalExamples: [LessonGoalExample]?
	
	init(
		goalText: String,
		title: String,
		lessonGoalExamples: [LessonGoalExample] = []
	) {
		self.goalText = goalText
		self.title = title
		self.lessonGoalExamples = lessonGoalExamples
	}
	
	func toFirebase() -> [String: Any] {
		return [
			"_goalText": goalText,
			"_title": title
		]
	}
}

@Observable
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

@Observable
class NewLessonVocabUsed: Identifiable, Codable {
	var id: String
	var title: String
	var helpText: String
	
	var vocabIDs: [String]
	
	
	init(
		id: String = UUID().uuidString,
		title: String,
		helpText: String,
		vocabIDs: [String] = []
	) {
		self.id = id
		self.title = title
		self.helpText = helpText
		self.vocabIDs = vocabIDs
	}
}

@Observable
class LessonGrammar: Identifiable, Codable {
	var title: String
	var desc: String
	
	var LessonGrammarPages: [LessonGrammarPage]?
	
	init(
		title: String,
		desc: String,
		LessonGrammarPages: [LessonGrammarPage] = []
	) {
		self.title = title
		self.desc = desc
		self.LessonGrammarPages = LessonGrammarPages
	}
	
	func toFirebase() -> [String: Any] {
		return [
			"_title": title,
			"_desc": desc
		]
	}
}

@Observable
class LessonGrammarPage: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	var example: String
	var order: Int
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
		example: String,
		order: Int = 0
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.example = example
		self.order = order
	}
}

@Observable
class LessonPractice: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	
	var mulitpleChoice: [LessonpracticeMultipleChoice]?
	var sentenceBuilding: [LessonpracticeSentenceBuilding]?
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
		mulitpleChoice: [LessonpracticeMultipleChoice] = [],
		sentenceBuilding: [LessonpracticeSentenceBuilding] = []
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.mulitpleChoice = mulitpleChoice
		self.sentenceBuilding = sentenceBuilding
	}
	
	func toFirebase() -> [String: Any] {
		return [
			"_id": id,
			"_title": title,
			"_desc": desc
		]
	}
}

@Observable
class LessonpracticeMultipleChoice: Identifiable, Codable {
	var id: String
	var question: String
	var answers: [LessonPraticeMultipleChoiceAnswer]
	var correctAnswer: LessonPraticeMultipleChoiceAnswer
	
	init(
		id: String = UUID().uuidString,
		question: String,
		answers: [LessonPraticeMultipleChoiceAnswer],
		correctAnswer: LessonPraticeMultipleChoiceAnswer
	) {
		self.id = id
		self.question = question
		self.answers = answers
		self.correctAnswer = correctAnswer
	}
}

@Observable
class LessonPraticeMultipleChoiceAnswer: Identifiable, Codable {
	
	var id: String
	var answer: String
	var isCorret: Bool
	
	init(
		id: String = UUID().uuidString,
		answer: String,
		isCorret: Bool = false
	) {
		self.id = id
		self.answer = answer
		self.isCorret = isCorret
	}
	
}


@Observable
class LessonpracticeSentenceBuilding: Identifiable, Codable {
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

@Observable
class LessonCultureReference: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	
	var songs: [LessonCultureReferenceSong]?
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
	 	songs: [LessonCultureReferenceSong] = []
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.songs = songs
	}
	
	func toFirebase() -> [String: Any] {
		return [
			"_id": id,
			"_title": title,
			"_desc": desc
		]
	}
}

@Observable
class LessonCultureReferenceSong: Identifiable, Codable {
	var id: String
	var title: String
	var desc: String
	var youtubeLinkID: String
	var youtubeStartTimestamp: Int
	var youtubeEndTimestamp: Int
	
	init(
		id: String = UUID().uuidString,
		title: String,
		desc: String,
		youtubeLinkID: String,
		youtubeStartTimestamp: Int,
		youtubeEndTimestamp: Int
	) {
		self.id = id
		self.title = title
		self.desc = desc
		self.youtubeLinkID = youtubeLinkID
		self.youtubeStartTimestamp = youtubeStartTimestamp
		self.youtubeEndTimestamp = youtubeEndTimestamp
	}
}
