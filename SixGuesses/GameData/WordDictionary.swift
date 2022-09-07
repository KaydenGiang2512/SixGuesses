//
//  WordDictionary.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation

class WordDictionary: ObservableObject {
  
    // Declaring the initial variables
    var wordLength: Int
    @Published var words: [String] = []

    init(length: Int) {
        wordLength = length

        // This guard clause ensures that the text file containing the vocabularies is found within the project,
        // and the contents of the file are readable by the processor
        guard
            let fileUrl = Bundle.main.url(forResource: "5-Letter-Words", withExtension: ""),
            let dictionary = try? String(contentsOf: fileUrl, encoding: .utf8) else {
            return
        }

        // This for-loop goes through each word in the entire dictionary with the separator being a new line,
        // then appending each word into a new array in capitalized form
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

