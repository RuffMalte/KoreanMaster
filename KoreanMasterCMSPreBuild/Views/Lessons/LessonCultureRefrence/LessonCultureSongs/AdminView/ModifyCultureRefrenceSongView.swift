//
//  ModifyCultureRefrenceSongView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 21.03.24.
//

import SwiftUI

struct ModifyCultureRefrenceSongView: View {
	
	@State var lessonCultureReferenceSong: LessonCultureReferenceSong
	var removeFuntion: () -> Void

    var body: some View {
		HStack {
			VStack {
				TextField("Title", text: $lessonCultureReferenceSong.title)
				TextField("Desc", text: $lessonCultureReferenceSong.desc)
				
				HStack {
					if !lessonCultureReferenceSong.image.isEmpty {
						AsyncImage(url: URL(string: lessonCultureReferenceSong.image)) { image in
							image.resizable()
								.frame(width: 100, height: 100)
						} placeholder: {
							ProgressView()
						}
					}
					
					TextField("Link", text: $lessonCultureReferenceSong.image)
				}
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
