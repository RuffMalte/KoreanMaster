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
		ScrollView(.horizontal, showsIndicators: false) {
			 HStack {
				 Button {
					 let newLessonTag = lessonTag
					 
					 let emptyTag = LessonTagItem(tagName: "", tagColor: .blue)
					 if lessonTag.lessonTagItems != nil {
						 newLessonTag.lessonTagItems?.append(emptyTag)
					 } else {
						 newLessonTag.lessonTagItems = [emptyTag]
					 }
					 lessonTag = LessonTag(title: newLessonTag.title, lessonTagItems: newLessonTag.lessonTagItems ?? [])
					 
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
    }
}

#Preview {
	ModifyLessonTagsView(lessonTag: LessonTag.example)
}
