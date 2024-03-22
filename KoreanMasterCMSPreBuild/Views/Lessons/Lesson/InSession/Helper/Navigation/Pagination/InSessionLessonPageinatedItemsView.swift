//
//  InSessionLessonPageinatedItemsView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonPageinatedItemsView<Item, ContentView>: View where Item: Identifiable, ContentView: View {
	private var items: [Item]
	@State private var currentIndex = 0
	private let itemView: (Item) -> ContentView
	private let onEnd: () -> Void
	@Binding private var showNavigationButtons: Bool
	@Binding private var hasAnswerBeenSelected: Bool

	

	init(items: [Item], showNavigationButtons: Binding<Bool> = .constant(true), hasAnswerBeenSelected: Binding<Bool> = .constant(true), onEnd: @escaping () -> Void, @ViewBuilder itemView: @escaping (Item) -> ContentView) {
		self.items = items
		self._showNavigationButtons = showNavigationButtons
		self._hasAnswerBeenSelected = hasAnswerBeenSelected
		self.onEnd = onEnd
		self.itemView = itemView
	}
	
	var body: some View {
		VStack {
			if items.indices.contains(currentIndex) {
				
				Spacer()
				
				itemView(items[currentIndex])
					.onChange(of: currentIndex) { oldValue, newValue in
						withAnimation {
							showNavigationButtons = false
							hasAnswerBeenSelected = false
						}
					}
				
				Spacer()
				
				if currentIndex + 1 == items.count {
					if showNavigationButtons {
						HStack {
							InSessionLessonNavBackButtonView(currentIndex: $currentIndex)
								.disabled(currentIndex == 0)
							InSessionSwitchSubLessonButtonView(switchLesson: onEnd)
						}
					} else {
						InSessionLessonPraticeShowAnswerButtonView(
							showNavigationButtons: $showNavigationButtons,
							hasAnswerBeenSelected: $hasAnswerBeenSelected)
					}
				} else {
					if showNavigationButtons {
						HStack {
							InSessionLessonNavBackButtonView(currentIndex: $currentIndex)
								.disabled(currentIndex == 0)
							InSessionLessonNavNextButtonView(
								currentIndex: $currentIndex,
								amount: items.count)
						}
					} else {
						InSessionLessonPraticeShowAnswerButtonView(
							showNavigationButtons: $showNavigationButtons,
							hasAnswerBeenSelected: $hasAnswerBeenSelected)
					}
				}
			} else {
				ContentUnavailableView("No Items found", systemImage: "exclamationmark.triangle.fill")
			}
		}
	}
}


