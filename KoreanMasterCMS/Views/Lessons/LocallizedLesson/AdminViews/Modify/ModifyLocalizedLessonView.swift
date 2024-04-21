//
//  ModifyLocalizedLessonView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 07.03.24.
//

import SwiftUI

struct ModifyLocalizedLessonView: View {
	
	@State var localizedLesson: LocalizedLessons
	
    var body: some View {
		Form {
			Section {
				
				//nothing here for now until the saving is figured out
				//placeholder
				
				Text("Language: \(localizedLesson.language)")
				Text("Info: \(localizedLesson.info)")

				
			}
		}
    }
}

#Preview {
	ModifyLocalizedLessonView(localizedLesson: LocalizedLessons.singleEnglishExample)
}
