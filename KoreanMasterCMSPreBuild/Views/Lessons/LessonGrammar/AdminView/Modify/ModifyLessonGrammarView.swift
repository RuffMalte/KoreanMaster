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
				GeometryReader { geo in
					HStack {
						List {
							Button {
								addNewPage()
								reorderPages()
							} label: {
								Label("Add New Page", systemImage: "plus")
							}
							
							ForEach(lessonGrammar.LessonGrammarPages ?? []) { page in
								ModifyLessonGrammarPageListCellView(
									lessonGrammarPage: page,
									increaseOrder: {
										withAnimation {
											increaseOrder(of: page.id)
										}
									},
									decreaseOrder: {
										withAnimation {
											decreaseOrder(of: page.id)
										}
									},
									removeFuntion: {
										lessonGrammar.LessonGrammarPages?.removeAll(where: { $0.id == page.id })
									}
								)
								.padding(.vertical, 5)
							}
						}
						.frame(width: geo.size.width / 2, height: geo.size.height)
						.onAppear(perform: reorderPages)
						
						InSessionLessonGrammarView(grammar: lessonGrammar, switchLesson: {})
							.padding()
							.frame(width: geo.size.width / 2, height: geo.size.height)

						
					}
					.navigationTitle("Lesson Grammar Pages")
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
	
	func addNewPage() {
		let newOrder = (lessonGrammar.LessonGrammarPages?.count ?? 0) + 1
		let newPage = LessonGrammarPage.empty
		newPage.order = newOrder
		lessonGrammar.LessonGrammarPages?.append(newPage)
	}
	
	func reorderPages() {
		guard var pages = lessonGrammar.LessonGrammarPages else { return }
		pages.sort(by: { $0.order < $1.order })
		for (index, _) in pages.enumerated() {
			pages[index].order = index + 1
		}
		lessonGrammar.LessonGrammarPages = pages
	}
	
	func increaseOrder(of pageId: String) {
		guard var pages = lessonGrammar.LessonGrammarPages else { return }
		if let currentIndex = pages.firstIndex(where: { $0.id == pageId }),
		   currentIndex < pages.count - 1 {
			// Swap the order values of the adjacent pages
			let nextPage = pages[currentIndex + 1]
			pages[currentIndex].order = nextPage.order
			nextPage.order = pages[currentIndex].order - 1
			
			// Sort the pages based on the new order
			pages.sort(by: { $0.order < $1.order })
			lessonGrammar.LessonGrammarPages = pages
		}
	}
	
	func decreaseOrder(of pageId: String) {
		guard var pages = lessonGrammar.LessonGrammarPages else { return }
		if let currentIndex = pages.firstIndex(where: { $0.id == pageId }),
		   currentIndex > 0 {
			// Swap the order values of the adjacent pages
			let previousPage = pages[currentIndex - 1]
			pages[currentIndex].order = previousPage.order
			previousPage.order = pages[currentIndex].order + 1
			
			// Sort the pages based on the new order
			pages.sort(by: { $0.order < $1.order })
			lessonGrammar.LessonGrammarPages = pages
		}
	}

}

#Preview {
	ModifyLessonGrammarView(lessonGrammar: LessonGrammar.example, language: "English")
}
