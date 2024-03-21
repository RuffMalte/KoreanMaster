//
//  ModifyLessonGrammarView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 16.03.24.
//

import SwiftUI

struct ModifyLessonGrammarView: View {
	
	@State var lessonGrammar: LessonGrammar
	var language: String
	
    var body: some View {
		Section {
			TextField("Title", text: $lessonGrammar.title)
			TextField("Desc", text: $lessonGrammar.desc)
			
			
			NavigationLink {
				List {
					Button {
						lessonGrammar.LessonGrammarPages?.append(LessonGrammarPage.empty)
					} label: {
						Label("Add New Page", systemImage: "plus")
					}

					ForEach(lessonGrammar.LessonGrammarPages ?? []) { page in
						ModifyLessonGrammarPageListCellView(lessonGrammarPage: page, removeFuntion: {
							lessonGrammar.LessonGrammarPages?.removeAll(where: { $0.id == page.id })
						})
						.padding(.vertical, 5)
					}
				}
			} label: {
				NavLinkHeaderView(headerText: "Lesson Grammar Pages", headerSFIcon: "sparkles.rectangle.stack.fill", count: lessonGrammar.LessonGrammarPages?.count ?? 0)
			}

			
			
			
		} header: {
			Text("Grammar for this Lesson")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	ModifyLessonGrammarView(lessonGrammar: LessonGrammar.example, language: "English")
}
