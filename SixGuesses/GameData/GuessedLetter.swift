//
//  GuessedLetter.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation
import SwiftUI

// Creating an enum containing all the possible cases of a letter in a guessed word
enum LetterStatus: String {
    case unknown = "Unknown"
    case notInWord = "Not in Word"
    case notInPosition = "In Word, But Not This Position"
    case inPosition = "Correct and In Position"
}

struct GuessedLetter: Identifiable {
  
    // Declaring the initial variables
    var id = UUID()
    var letter: String
    var status: LetterStatus = .unknown

    //Declaring color variables indicating the different statuses of a letter
    var statusColor: Color {
        switch status {
            case .unknown:
                return .primary
            case .notInWord:
                return .gray
            case .notInPosition:
                return .yellow
            case .inPosition:
                return .green
        }
    }
}
