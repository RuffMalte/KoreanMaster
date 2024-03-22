//
//  InSessionLessonSongItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonSongItemView: View {
	
	@State var song: LessonCultureReferenceSong
	
    var body: some View {
		VStack {
			AsyncImage(url: URL(string: song.image)) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
					.cornerRadius(10)
			} placeholder: {
				ProgressView()
			}
			
			Text(song.title)
				.font(.system(.title3, design: .rounded, weight: .bold))
				.padding()
			
			Text(song.desc)
				.font(.system(.body, design: .default, weight: .regular))
				.padding()
			
			
			Link("Link", destination: URL(string: song.link)!)
				.font(.system(.body, design: .default, weight: .bold))
		}
    }
}
