//
//  JSONView.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 02.03.24.
//

import SwiftUI

struct JSONView<Model: Codable>: View {
	var model: Model
	var jsonText: String {
		convertModelToJson(model: model) ?? "Invalid JSON"
	}
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				Text(jsonText)
					.font(.system(.body, design: .monospaced))
					.padding()
			}
		}
	}
	
	func convertModelToJson(model: Model) -> String? {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted // Format JSON for readability
		if let jsonData = try? encoder.encode(model),
		   let jsonString = String(data: jsonData, encoding: .utf8) {
			return jsonString
		} else {
			return nil // In case of encoding failure
		}
	}
}

#Preview {
	JSONView(model: CourseLanguage.simpleExample)
}
