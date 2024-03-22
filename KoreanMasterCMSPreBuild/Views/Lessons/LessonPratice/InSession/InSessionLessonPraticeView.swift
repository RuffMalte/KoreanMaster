//
//  InSessionLessonPraticeView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 22.03.24.
//

import SwiftUI

struct InSessionLessonPraticeView: View {
	
	@State var pratice: LessonPractice
	
    var body: some View {
		InSessionLessonHeaderView(title: pratice.title, subtitle: pratice.desc) {
			VStack {
				
				
				
			}
		}
    }
}
