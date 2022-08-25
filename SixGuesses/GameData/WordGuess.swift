//
//  WordGuess.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation

enum GuessStatus {
  case pending
  case complete
  case invalidWord
}

struct WordGuess: Identifiable {
  var id = UUID()
  var word: [GuessedLetter] = []
  var status: GuessStatus = .pending

  var letters: String {
    return word.reduce("") { partialResult, nextLetter in
      partialResult.appending(nextLetter.letter)
    }
  }
}
