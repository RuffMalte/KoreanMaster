//
//  InSessionLessonPageinatedItemsView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonPageinatedItemsView<Item, ContentView>: View where Item: Identifiable, ContentView: View{
	private var items: [Item]
	@State private var currentIndex = 0
	private let itemView: (Item) -> ContentView
	private let onEnd: () -> Void
	
	init(items: [Item], onEnd: @escaping () -> Void, @ViewBuilder itemView: @escaping (Item) -> ContentView) {
		self.items = items
		self.onEnd = onEnd
		self.itemView = itemView
	}
	
	var body: some View {
		VStack {
			if items.indices.contains(currentIndex) {
				itemView(items[currentIndex])
				
				if currentIndex + 1 == items.count {
					InSessionSwitchSubLessonButtonView(switchLesson: onEnd)
				} else {
					HStack {
						Button("Previous") {
							withAnimation {
								currentIndex = max(currentIndex - 1, 0)
							}
						}
						
						Button("Next") {
							withAnimation {
								currentIndex = min(currentIndex + 1, items.count - 1)
							}
						}
					}
				}
			} else {
				ContentUnavailableView("No Items found", systemImage: "exclamationmark.triangle.fill")
			}
		}
	}
}
