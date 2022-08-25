//
//  WordDictionary.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation

class WordDictionary: ObservableObject {
  var wordLength: Int
  @Published var words: [String] = []

  init(length: Int) {
    wordLength = length

    guard
      let fileUrl = Bundle.main.url(forResource: "5-Letter-Words", withExtension: ""),
      let dictionary = try? String(contentsOf: fileUrl, encoding: .utf8) else {
        return
      }

    for word in dictionary.split(separator: "\n") {
      let newWord = String(word)
      if newWord.count == wordLength {
        words.append(newWord.uppercased())
      }
    }
  }

  func isValidWord(_ word: String) -> Bool {
    let casedWord = word.uppercased()
    return words.contains { $0 == casedWord }
  }
}

