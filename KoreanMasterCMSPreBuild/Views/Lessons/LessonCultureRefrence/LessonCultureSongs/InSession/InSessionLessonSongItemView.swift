//
//  InSessionLessonSongItemView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI
import YouTubePlayerKit

struct InSessionLessonSongItemView: View {
	
	var song: LessonCultureReferenceSong
	
    var body: some View {
		VStack {
			YouTubePlayerView(
				YouTubePlayer(
					source: .video(
						id: song.youtubeLinkID,
						startSeconds: song.youtubeStartTimestamp,
						endSeconds: song.youtubeEndTimestamp
					), 
					configuration: .init(
						loopEnabled: true
					)
				)
			) { state in
				switch state {
				case .idle:
					ProgressView()
				case .ready:
					EmptyView()
				case .error(let error):
					Text(verbatim: "YouTube player couldn't be loaded")
				}
			}
			.clipShape(RoundedRectangle(cornerRadius: 16))

			Text(song.title)
				.font(.system(.title3, design: .rounded, weight: .bold))
				.padding()
			
			Text(song.desc)
				.font(.system(.body, design: .default, weight: .regular))
				.padding()
			
		}
    }
}
