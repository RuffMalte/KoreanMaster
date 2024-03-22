//
//  InSessionLessonCultureRefrenceView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonCultureRefrenceView: View {
	
	@State var culture: LessonCultureReference
	var switchLesson: () -> Void
	
    var body: some View {
		InSessionLessonHeaderView(title: culture.title, subtitle: culture.desc) {
			VStack {
				InSessionLessonPageinatedItemsView(
					items: culture.songs ?? [],
					isLastPaginated: true,
					onEnd: switchLesson
				) { song in
					InSessionLessonSongItemView(song: song)
				}
			}
		}
    }
}
