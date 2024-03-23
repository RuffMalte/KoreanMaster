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
	
	@State private var isGettingNewVideo: Bool = false
	
    var body: some View {
		VStack {
			Group {
				if isGettingNewVideo {
					RoundedRectangle(cornerRadius: 0)
						.foregroundStyle(.bar)
				} else {
					YouTubePlayerView(
						YouTubePlayer(
							source: .video(
								id: song.youtubeLinkID,
								startSeconds: song.youtubeStartTimestamp,
								endSeconds: song.youtubeEndTimestamp
							),
							configuration: .init(
								endTime: song.youtubeEndTimestamp,
								loopEnabled: false,
								startTime: song.youtubeStartTimestamp
							)
						)
					) { state in
						switch state {
						case .idle:
							ProgressView()
						case .ready:
							EmptyView()
						case .error(_):
							Text(verbatim: "YouTube player couldn't be loaded")
						}
					}
				}
			}
			.clipShape(RoundedRectangle(cornerRadius: 16))
			.onChange(of: song.youtubeLinkID) { oldValue, newValue in
				Task {
					isGettingNewVideo = true
					try await Task.sleep(nanoseconds: 1_000_000)
					isGettingNewVideo = false
				}
			}
			Spacer()
			
			VStack(spacing: 8) {
				VStack {
					Text("at")
						.font(.system(.footnote, design: .default, weight: .light))
					HStack {
						Text(String(format: "%02d:%02d", Int(song.youtubeStartTimestamp / 60), Int(song.youtubeStartTimestamp) % 60)
						)
						Text(" - ")
						Text(String(format: "%02d:%02d",
							Int(song.youtubeEndTimestamp / 60),
							Int(song.youtubeEndTimestamp) % 60)
						)
					}
					.font(.system(.subheadline, design: .monospaced, weight: .regular))
				}
				
				VStack {
					Text(song.title)
						.font(.system(.title3, design: .rounded, weight: .bold))
					
					Text(song.desc)
						.font(.system(.body, design: .default, weight: .regular))
				}
			}
			.padding()
			
			Spacer()
			
		}
    }
}
