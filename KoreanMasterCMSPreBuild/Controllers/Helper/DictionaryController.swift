//
//  DictionaryController.swift
//  KoreanMasterCMSPreBuild
//
//  Created by Malte Ruff on 14.03.24.
//

import Foundation

class DictionaryController: ObservableObject {
	
	
	///currently only supports english
	func getDictForWord(word: String, completion: @escaping (Dictionary?, Error?) -> Void) {
		let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
		
		guard let url = URL(string: urlString) else {
			completion(nil, NSError(domain: "InvalidURL", code: 1, userInfo: nil))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(nil, error)
				return
			}
			
			guard let data = data else {
				completion(nil, NSError(domain: "NoData", code: 2, userInfo: nil))
				return
			}
			
			do {
				let dictionaryEntries = try JSONDecoder().decode([Dictionary].self, from: data)
				completion(dictionaryEntries.first, nil)
			} catch {
				completion(nil, error)
			}
		}
		
		task.resume()
	}
	
	
//	func createVocabFromDict(_ dict: Dictionary) -> Vocab {
//		let vocab = Vocab.empty
//		vocab.word = dict.word
//		vocab.phonetic = dict.phonetic
//		vocab.origin = dict.origin
//		vocab.meanings = dict.meanings?.map { meaning in
//			Meaning(partOfSpeech: meaning.partOfSpeech, definitions: meaning.definitions?.map { definition in
//				Definition(definition: definition.definition, example: definition.example, synonyms: definition.synonyms, antonyms: definition.antonyms)
//			})
//		}
//		
//		return vocab
//	}
	
	
}
