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
			TextField("", text: $localizedLesson.title)
				
			Text("Title: \(localizedLesson.title)")
			
			Text("Pages: \(localizedLesson.pages?.count ?? 99999)")
			
		}
    }
}

#Preview {
	ModifyCourseLocalizedView(localizedLesson: Course.detailExample.localizedLessons![0])
}
