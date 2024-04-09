//
//  ModifyCultureRefrenceSongView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI
//import YouTubePlayerKit

struct ModifyCultureRefrenceSongView: View {
	
	@State var lessonCultureReferenceSong: LessonCultureReferenceSong
	var removeFuntion: () -> Void

	
	@State private var isReloading: Bool = false
	
    var body: some View {
		HStack {
			VStack {
				TextField("Title", text: $lessonCultureReferenceSong.title)
				TextField("Desc", text: $lessonCultureReferenceSong.desc)
				
				GeometryReader { geo in
					HStack {
						Group {
							if !isReloading {
//								YouTubePlayerView(
//									YouTubePlayer(
//										source: .video(
//											id: lessonCultureReferenceSong.youtubeLinkID,
//											startSeconds: lessonCultureReferenceSong.youtubeStartTimestamp,
//											endSeconds: lessonCultureReferenceSong.youtubeEndTimestamp
//										),
//										configuration: .init(
//											loopEnabled: true
//										)
//									)
//								) { state in
//									switch state {
//									case .idle:
//										ProgressView()
//									case .ready:
//										EmptyView()
//									case .error(let error):
//										Text(verbatim: "YouTube player couldn't be loaded. " + error.localizedDescription)
//									}
//								}
//								.clipShape(RoundedRectangle(cornerRadius: 16))
							} else {
								ProgressView()
							}
						}
						.frame(width: geo.size.width / 2)
						
						VStack {
							TextField("Youtube Link", text: $lessonCultureReferenceSong.youtubeLinkID)
							
							HStack {
								TextField("Start Timestamp", value: $lessonCultureReferenceSong.youtubeStartTimestamp, formatter: NumberFormatter())
								TextField("End Timestamp", value: $lessonCultureReferenceSong.youtubeEndTimestamp, formatter: NumberFormatter())
							}
							
							Button {
								isReloading = true
								Task {
									try await Task.sleep(nanoseconds: 100_000_000)
									isReloading = false
								}
							} label: {
								Label("Reload youtube link", systemImage: "arrow.clockwise")
							}
						}
					}
				}
				.frame(height: 200)
			}
			Button {
				removeFuntion()
			} label: {
				Image(systemName: "xmark")
			}
		}
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	ModifyCultureRefrenceSongView(lessonCultureReferenceSong: LessonCultureReferenceSong.multipleExample[0], removeFuntion: {print("Deleted")})
}
