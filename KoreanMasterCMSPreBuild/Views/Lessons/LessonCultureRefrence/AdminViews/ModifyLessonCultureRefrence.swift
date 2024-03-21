//
//  ModifyLessonCultureRefrence.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct ModifyLessonCultureRefrence: View {
	
	@State var lessonCultureRefrence: LessonCultureReference
	
    var body: some View {
		Section {
			TextField("Title", text: $lessonCultureRefrence.title)
			TextField("Desc", text: $lessonCultureRefrence.desc)
			
			
			NavigationLink {
				List {
					Button {
						lessonCultureRefrence.songs?.append(LessonCultureReferenceSong.empty)
					} label: {
						Label("Add Song", systemImage: "plus")
					}
					
					ForEach(lessonCultureRefrence.songs ?? []) { song in
						ModifyCultureRefrenceSongView(lessonCultureReferenceSong: song, removeFuntion: {
							lessonCultureRefrence.songs?.removeAll(where: { $0.id == song.id })
						})
					}
					
				}
			} label: {
				NavLinkHeaderView(headerText: "Songs", headerSFIcon: "music.quarternote.3", count: lessonCultureRefrence.songs?.count ?? 999)
			}

			
			
			
			
			
		} header: {
			Text("Culture Refrences")
				.font(.system(.title2, design: .rounded, weight: .bold))
				.foregroundStyle(.tint)
		}
    }
}

#Preview {
	ModifyLessonCultureRefrence(lessonCultureRefrence: LessonCultureReference.example)
}
