//
//  SixGuesses.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation
import SwiftUI

enum GameState {
  case initializing
  case new
  case inprogress
  case won
  case lost
}

class SixGuesses: ObservableObject {
  let wordLength = 5
  let maxGuesses = 6
  var dictionary: WordDictionary
  var status: GameState = .initializing

  @AppStorage("GameRecord") var gameRecord = ""

  @Published var targetWord: String
  @Published var currentGuess = 0
  @Published var guesses: [WordGuess]

  init() {
    // 1
    dictionary = WordDictionary(length: wordLength)
    // 2
    let totalWords = dictionary.words.count
    let randomWord = Int.random(in: 0..<totalWords)
    let word = dictionary.words[randomWord]
    // 3
    targetWord = word
    #if DEBUG
    print("selected word: \(word)")
    #endif
    // 4
    guesses = .init()
    guesses.append(WordGuess())
    status = .new
  }

  func addKey(letter: String) {
    // 1
    if status == .new {
      status = .inprogress
    }
    // 2
    guard status == .inprogress else {
      return
    }

    // 3
    switch letter {
    case "<":
      deleteLetter()
    case ">":
      checkGuess()
    default:
      // 4
      if guesses[currentGuess].word.count < wordLength {
        let newLetter = GuessedLetter(letter: letter)
        guesses[currentGuess].word.append(newLetter)
      }
    }
  }

  func deleteLetter() {
    let currentLetters = guesses[currentGuess].word.count
    guard currentLetters > 0 else { return }
    guesses[currentGuess].word.remove(at: currentLetters - 1)
  }

  func checkGuess() {
    // 1
    guard guesses[currentGuess].word.count == wordLength  else { return }

    // 2
    if !dictionary.isValidWord(guesses[currentGuess].letters) {
      guesses[currentGuess].status = .invalidWord
      return
    }

    // 1
    guesses[currentGuess].status = .complete
    // 2
    var targetLettersRemaining = Array(targetWord)
    // 3
    for index in guesses[currentGuess].word.indices {
      // 4
      let stringIndex = targetWord.index(targetWord.startIndex, offsetBy: index)
      let letterAtIndex = String(targetWord[stringIndex])
      // 5
      if letterAtIndex == guesses[currentGuess].word[index].letter {
        // 6
        guesses[currentGuess].word[index].status = .inPosition
        // 7
        if let letterIndex =
          targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
          targetLettersRemaining.remove(at: letterIndex)
        }
      }
    }

    // 1
    for index in guesses[currentGuess].word.indices
      .filter({ guesses[currentGuess].word[$0].status == .unknown }) {
      // 2
      let letterAtIndex = guesses[currentGuess].word[index].letter
      // 3
      var letterStatus = LetterStatus.notInWord
      // 4
      if targetWord.contains(letterAtIndex) {
        // 5
        if let guessedLetterIndex =
          targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
          letterStatus = .notInPosition
          targetLettersRemaining.remove(at: guessedLetterIndex)
        }
      }
      // 6
      guesses[currentGuess].word[index].status = letterStatus
    }

    if targetWord == guesses[currentGuess].letters {
      status = .won
      gameRecord += "\(currentGuess + 1)"

      return
    }

    if currentGuess < maxGuesses - 1 {
      guesses.append(WordGuess())
      currentGuess += 1
    } else {
      status = .lost
      gameRecord += "L"
    }
  }

  func newGame() {
    let totalWords = dictionary.words.count
    let randomWord = Int.random(in: 0..<totalWords)
    targetWord = dictionary.words[randomWord]
    print("Selected word: \(targetWord)")

    currentGuess = 0
    guesses = []
    guesses.append(WordGuess())
    status = .new
  }
    
    func statusForLetter(letter: String) -> LetterStatus {
      // 1
      if letter == "<" || letter == ">" {
        return .unknown
      }

      // 2
      let finishedGuesses = guesses.filter { $0.status == .complete }
      // 3
      let guessedLetters =
        finishedGuesses.reduce([LetterStatus]()) { partialResult, guess in
        // 4
        let guessStatuses =
          guess.word.filter { $0.letter == letter }.map { $0.status }
        // 5
        var currentStatuses = partialResult
        currentStatuses.append(contentsOf: guessStatuses)
        return currentStatuses
      }

      // 6
      if guessedLetters.contains(.inPosition) {
        return .inPosition
      }
      if guessedLetters.contains(.notInPosition) {
        return .notInPosition
      }
      if guessedLetters.contains(.notInWord) {
        return .notInWord
      }

      return .unknown
    }
    
    func colorForKey(key: String) -> Color {
      let status = statusForLetter(letter: key)

      switch status {
      case .unknown:
        return Color(UIColor.systemBackground)
      case .inPosition:
        return Color.green
      case .notInPosition:
        return Color.yellow
      case .notInWord:
        return Color.gray.opacity(0.67)
      }
    }
}


extension SixGuesses {
  convenience init(word: String) {
    self.init()
    self.targetWord = word
  }

  static func inProgressGame() -> SixGuesses {
    let game = SixGuesses(word: "SMILE")
    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    return game
  }

  static func wonGame() -> SixGuesses {
    let game = SixGuesses(word: "SMILE")
    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    return game
  }

  static func lostGame() -> SixGuesses {
    let game = SixGuesses(word: "SMILE")

    game.addKey(letter: "P")
    game.addKey(letter: "I")
    game.addKey(letter: "A")
    game.addKey(letter: "N")
    game.addKey(letter: "O")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "P")
    game.addKey(letter: "O")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "A")
    game.addKey(letter: "R")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "M")
    game.addKey(letter: "E")
    game.addKey(letter: "L")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    return game
  }

  static func complexGame() -> SixGuesses {
    let game = SixGuesses(word: "THEME")

    game.addKey(letter: "E")
    game.addKey(letter: "E")
    game.addKey(letter: "R")
    game.addKey(letter: "I")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "E")
    game.addKey(letter: "E")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    game.addKey(letter: "T")
    game.addKey(letter: "H")
    game.addKey(letter: "E")
    game.addKey(letter: "M")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    return game
  }
}
