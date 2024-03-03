//
//  CourseMocData.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import Foundation

extension Course {
	
	static var emptyCourse: Course = Course(section: 0, unit: 0)
	
	static var detailExample: Course = Course(
		section: 1,
		unit: 1,
		localizedLessons: [
			LocalizedLesson(
				language: "English",
				title: "Lesson 1",
				description: "Description for lesson 1",
				help: "Help for lesson 1",
				pages: [
					LessonPage(pageTitle: "Page 1", content: "Content for page 1"),
					LessonPage(pageTitle: "Page 2", content: "Content for page 2"),
					LessonPage(pageTitle: "Page 3", content: "Content for page 3"),
					LessonPage(pageTitle: "Page 4", content: "Content for page 4"),
					LessonPage(pageTitle: "Page 5", content: "Content for page 5"),
				]),
			LocalizedLesson(
				language: "German",
				title: "Übung 1",
				description: "Beschreibung für Übung 1",
				help: "Hilfe für Übung 1",
				pages: [
					LessonPage(pageTitle: "Seite 1", content: "Inhalt für Seit 1"),
					LessonPage(pageTitle: "Seite 2", content: "Inhalt für Seit 2"),
					LessonPage(pageTitle: "Seite 3", content: "Inhalt für Seit 3"),
					LessonPage(pageTitle: "Seite 4", content: "Inhalt für Seit 4"),
					LessonPage(pageTitle: "Seite 5", content: "Inhalt für Seit 5"),
				])
		])
	
	
}
