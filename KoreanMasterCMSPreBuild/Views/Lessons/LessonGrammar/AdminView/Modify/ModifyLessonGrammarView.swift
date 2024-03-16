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
						let newPage = LessonGrammarPage(title: "", desc: "", example: "")
						lessonGrammar.LessonGrammarPages?.append(newPage)
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
				HStack {
					Label("Lesson Grammar Pages", systemImage: "sparkles.rectangle.stack.fill")
						
					Spacer()
					Label(lessonGrammar.LessonGrammarPages?.count.description ?? "Unkown", systemImage: "number")
						.font(.system(.headline, design: .monospaced, weight: .regular))
					
					Image(systemName: "chevron.right")
				}
				.font(.system(.headline, design: .rounded, weight: .bold))
			}

			
			
			
		} header: {
			Text("New Vocab for this Lesson")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}

    }
}

#Preview {
	ModifyLessonGrammarView(lessonGrammar: LessonGrammar.example, language: "English")
}
