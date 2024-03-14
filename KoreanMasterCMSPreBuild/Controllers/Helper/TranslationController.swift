//
//  TranslationController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import Foundation

class TranslationController {
	
	
	func getTranslation(for text: String, targetLang: String, completion: @escaping (String?, Error?) -> Void) {
		let endpoint = "https://api-free.deepl.com/v2/translate"
		guard let url = URL(string: endpoint) else {
			completion(nil, NSError(domain: "InvalidURL", code: 1, userInfo: nil))
			return
		}
		
		guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
			completion(nil, NSError(domain: "InvalidText", code: 2, userInfo: nil))
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.addValue("DeepL-Auth-Key \(deeplAPIkey)", forHTTPHeaderField: "Authorization")
		request.addValue("YourApp/1.2.3", forHTTPHeaderField: "User-Agent")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		
		let bodyParameters = "text=\(encodedText)&target_lang=\(targetLang)"
		request.httpBody = bodyParameters.data(using: .utf8)
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, NSError(domain: "NoData", code: 3, userInfo: nil))
				return
			}
			
			// Debugging: Print the raw response
			let rawResponse = String(decoding: data, as: UTF8.self)
			print("Raw API Response: \(rawResponse)")
			
			do {
				let decoder = JSONDecoder()
				let jsonResponse = try decoder.decode(DeepLResponse.self, from: data)
				if let translation = jsonResponse.translations.first?.text {
					completion(translation, nil)
				} else {
					completion(nil, NSError(domain: "NoTranslation", code: 4, userInfo: nil))
				}
			} catch {
				completion(nil, error)
			}
		}
		
		task.resume()
	}
	
	// The response structure
	struct DeepLResponse: Codable {
		let translations: [Translation]
	}
	
	struct Translation: Codable {
		let detected_source_language: String
		let text: String
	}
}
