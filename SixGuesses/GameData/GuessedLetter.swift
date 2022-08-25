//
//  GuessedLetter.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation
import SwiftUI

enum LetterStatus: String {
  case unknown = "Unknown"
  case notInWord = "Not in Word"
  case notInPosition = "In Word, But Not This Position"
  case inPosition = "Correct and In Position"
}

struct GuessedLetter: Identifiable {
  var id = UUID()
  var letter: String
  var status: LetterStatus = .unknown

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
