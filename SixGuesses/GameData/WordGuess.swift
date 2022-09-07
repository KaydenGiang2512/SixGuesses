//
//  WordGuess.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation

//Creating an enum containing the different statuses of a guess attempt
enum GuessStatus {
    case pending
    case complete
    case invalidWord
}

struct WordGuess: Identifiable {
    var id = UUID()
    var word: [GuessedLetter] = []
    var status: GuessStatus = .pending

    // Creating an array variable called letters, then reducing it into a single string through concatenation
    var letters: String {
        return word.reduce("") { partialResult, nextLetter in
            partialResult.appending(nextLetter.letter)
        }
    }
}
