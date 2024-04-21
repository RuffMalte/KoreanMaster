//
//  ModifyLessonTagsView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct ModifyLessonTagsView: View {
	
	@State var lessonTag: LessonTag
	
    var body: some View {
		Section {
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					Button {
						if lessonTag.lessonTagItems != nil {
							lessonTag.lessonTagItems?.append(LessonTagItem.emtpy)
						} else {
							lessonTag.lessonTagItems = [LessonTagItem.emtpy]
						}
					} label: {
						Image(systemName: "plus")
					}
					.font(.system(.footnote, design: .rounded, weight: .bold))
					.foregroundStyle(.secondary)
					.padding(5)
					.background {
						RoundedRectangle(cornerRadius: 5)
							.foregroundStyle(.secondary.opacity(0.2))
					}
					.buttonStyle(.borderless)
					
					
					ForEach(lessonTag.lessonTagItems ?? [], id: \.id) { tag in
						ModifyLessonTagItemView(tagItem: tag) {
							let newLessonTag = lessonTag
							newLessonTag.lessonTagItems?.removeAll(where: { $0.id == tag.id })
							lessonTag = LessonTag(title: newLessonTag.title, lessonTagItems: newLessonTag.lessonTagItems ?? [])
						}
					}
				}
			}
		} header: {
			Text("Tags")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
		
	}
}

#Preview {
	ModifyLessonTagsView(lessonTag: LessonTag.example)
}
