//
//  AllLocalVocabView.swift
//  KoreanMasterAppPreBuild
//
//  Created by Malte Ruff on 29.03.24.
//

import SwiftUI
import SwiftData

struct AllLocalVocabView: View {
	
	@Query var localVocabs: [UserLocalVocab]
	@Environment(\.modelContext) var modelContext
	
    var body: some View {
		VStack {
			List {
				ForEach(localVocabs) { localVocab in
					VStack {
						Text(localVocab.koreanVocab)
						Text(localVocab.localizedVocab)
					}
				}
				
			}
			
		}
    }
}

#Preview {
    AllLocalVocabView()
}
