//
//  ModifyCourseLocalizedView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 03.03.24.
//

import SwiftUI

struct ModifyCourseLocalizedView: View {
	
	@State var localizedLesson: LocalizedLesson
	
    var body: some View {
		Form {
			TextField("Title", text: $localizedLesson.title)
			TextField("Description", text: $localizedLesson.description)
			TextField("Help", text: $localizedLesson.help)
			
			ForEach(localizedLesson.pages ?? []) { page in
				Text(page.pageTitle)
				
			}
			
		}
    }
}

#Preview {
	ModifyCourseLocalizedView(localizedLesson: Course.detailExample.localizedLessons![0])
}
