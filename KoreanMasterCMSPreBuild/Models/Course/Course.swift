//
//  Course.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import Foundation

class Course: Identifiable, Encodable, Decodable {
	
	var id: String
	var section: Int
	var unit: Int
	
	var localizedLessons: [LocalizedLesson]?
	
	init(
		id: String = UUID().uuidString,
		 section: Int,
		 unit: Int,
		 localizedLessons: [LocalizedLesson]? = []
	) {
		self.id = id
		self.section = section
		self.unit = unit
		self.localizedLessons = localizedLessons
	}
	
	
	func getCourseComputedName() -> String {
		return "\(self.section) - \(self.unit)"
	}
	
	func toFirebaseDocument() -> [String: Any] {
		return [
			"id": self.id,
			"section": self.section,
			"unit": self.unit
		]
	}
}

class LocalizedLesson: Identifiable, Encodable, Decodable {
	
	var id: String
	var language: String
	
	var title: String
	var description: String
	var help: String
	
	
	var pages: [LessonPage]?
	
	
	init(
		id: String = UUID().uuidString,
		 language: String,
		 title: String,
		 description: String,
		 help: String,
		 pages: [LessonPage]? = []
	) {
		self.id = id
		self.language = language
		self.title = title
		self.description = description
		self.help = help
	}
	
	func toInfo() -> [String: Any] {
		return [
			"id": self.id,
			"description": self.description,
			"title": self.title,
			"help": self.help,
			"language": self.language
		]
	}

	
}

class LessonPage: Identifiable, Encodable, Decodable {
	
	var id: String
	var pageTitle: String
	
	var content: String?
	
	init(
		id: String = UUID().uuidString,
		pageTitle: String,
		content: String? = ""
	) {
		self.id = id
		self.pageTitle = pageTitle
		self.content = content
	}
	
	func toPage() -> [String: Any] {
		return [
			"id": self.id,
			"pageTitle": self.pageTitle
		]
	}
	
	
}
