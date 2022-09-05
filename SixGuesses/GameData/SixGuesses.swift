//
//  SixGuesses.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation
import SwiftUI

// Creating an enum containing all the possible states of the main gameplay to perform the appropriate logic
enum GameState {
    case initializing
    case new
    case inprogress
    case won
    case lost
}

class SixGuesses: ObservableObject {
    
    // Declaring initial game constants and variables
    let wordLength = 5
    let maxGuesses = 6
    var dictionary: WordDictionary
    var status: GameState = .initializing {
        didSet {
            if status == .lost || status == .won {
                gameState = ""
            }
        }
    }
    
    // Declaring the 3 App Storage variables to permanently store game data for later access
    @AppStorage("GameRecord") var gameRecord = ""
    @AppStorage("GameState") var gameState = ""
    @AppStorage("HardMode") var hardMode = false

    // Creating publishable variables to trigger view reload whenever their values are changed inside the core game logic
    @Published var targetWord: String
    @Published var currentGuess = 0
    @Published var guesses: [WordGuess]

    init() {
        
        // Creating a new instance of the Dictionary object with the constant set as the word length
        dictionary = WordDictionary(length: wordLength)
        
        // Creating constants to keep track of the dictionary's total number of words, choosing a random word using a for loop and a random function 
        // before assigning a variable to store the selected word
        let totalWords = dictionary.words.count
        let randomWord = Int.random(in: 0..<totalWords)
        let word = dictionary.words[randomWord]
        
        // Assigning the initial @Published var to the newly created variable containing the word, then print it to the console for debugging
        targetWord = word
        #if DEBUG
        print("selected word: \(word)")
        #endif
        // Initialize the guesses variable to an empty array to store the player's guess attempts, then setting the status as a new game
        guesses = .init()
        guesses.append(WordGuess())
        status = .new
    }

    func addKey(letter: String) {
        
        // In the new status, as soon as the player clicks on any key, the game changes to its inprogress state
        if status == .new {
            status = .inprogress
        }
        
        // If the game is not in the inprogress state, ignore all user input on the keyboard
        guard status == .inprogress else {
            return
        }
        
        // Creating a switch case to handle user input on the letter keys along with the special character keys (delete & enter buttons)
        switch letter {
        case "<":
            deleteLetter()
        case ">":
            checkGuess()
        default:
            
            // For each letter, check if the input word that the player guesses is shorter than the allowed word length. 
            // If so, then append that letter the current guess
            if guesses[currentGuess].word.count < wordLength {
                let newLetter = GuessedLetter(letter: letter)
                guesses[currentGuess].word.append(newLetter)
            }
        }
    }

    // This function handles events where the player clicks on the character key on the left (delete the most recent letter from right to left)
    func deleteLetter() {
        let currentLetters = guesses[currentGuess].word.count
        guard currentLetters > 0 else { return }
        guesses[currentGuess].word.remove(at: currentLetters - 1)
    }

    // This functoin handles events where the player clicks on the character key on the right (lock in the guess to check)
    func checkGuess() {
        
        // A guard clause checking if the current guess satisfies the provided word length of 5 letters.
        // If not, then return immediately and ignore the player's input
        guard guesses[currentGuess].word.count == wordLength  else { return }
        
        // Checking if the word is a valid one or not according to the list of words in the dictionary.
        // If not, then set the guess status to invalidWord and return immediately
        if !dictionary.isValidWord(guesses[currentGuess].letters) {
            guesses[currentGuess].status = .invalidWord
            return
        }

        // Once the user clicks enter on a guess attempt, set it's status to complete
        guesses[currentGuess].status = .complete
        
        // Creating an array containing the letters of the target word (selected by random)
        var targetLettersRemaining = Array(targetWord)
        
        // Looping through all the indices of the current guess one by one (each letter)
        for index in guesses[currentGuess].word.indices {
            
            // Getting the same index position of a letter in both the target word as well as the current guess to compare them
            let stringIndex = targetWord.index(targetWord.startIndex, offsetBy: index)
            let letterAtIndex = String(targetWord[stringIndex])
            
            // An if statement to decide whether a letter in the current guess matches up with a letter in the target word at a specific index 
            if letterAtIndex == guesses[currentGuess].word[index].letter {
                
                // If so, then mark the current guess letter's status to inPosition
                guesses[currentGuess].word[index].status = .inPosition
                
                // Once they match, get the first index of the letterAtIndex (after casting it to a Character in the characters array),
                // before unwrapping it as letterIndex. If the value does exist, remove that letter from the targetLettersRemaining array
                if let letterIndex =
                    targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
                    targetLettersRemaining.remove(at: letterIndex)
                }
            }
        }

        // Looping through all the indices of the current guess one by one with the unknown status, 
        // while filtering out the letters that are already deemed as inPosition
        for index in guesses[currentGuess].word.indices
            .filter({ guesses[currentGuess].word[$0].status == .unknown }) {
                
             // Getting the corresponding letter for a position in the current guess based on their index
            let letterAtIndex = guesses[currentGuess].word[index].letter
                
            // Set the initial status of the letters to notInWord
            var letterStatus = LetterStatus.notInWord
                
            // Checking if the letter appears in any given position of the target word
            if targetWord.contains(letterAtIndex) {
                
                // Getting the index position of the letterAtIndex to check if it's present in the target word
                if let guessedLetterIndex = targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
                    
                    // Hard Mode condition check, where even a letter that is misplaced will not be indicated
                    if hardMode {
                        letterStatus = .notInWord
                    } 
                    
                    // If Hard Mode is disabled, proceed to set the status of the letter to notInPosition if it appears in the word
                    else {
                        letterStatus = .notInPosition
                        targetLettersRemaining.remove(at: guessedLetterIndex)
                    }
                }
            }
            // Setting the status of the letter according to the value in the letterStatus variable, which is notInWord by default
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
    
    // This function when invoked, creates a brand new game instance, refreshing all the initializing variables
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
        
        // Ensures that either the enter or delete keys will return the letter status of unknown
        if letter == "<" || letter == ">" {
            return .unknown
        }
        
        // Only allowing the system to check if the guess is completed
        let finishedGuesses = guesses.filter { $0.status == .complete }
        
        // Using the reduce function to set the appropriate status to each letter in the guess using the LetterStatus enum
        let guessedLetters = finishedGuesses.reduce([LetterStatus]()) { partialResult, guess in
            let guessStatuses = guess.word.filter { $0.letter == letter }.map { $0.status }
                                                                       
            // Creating a copy of the partialResult since it is immutable, then sending the copy to the next code block
            var currentStatuses = partialResult
            currentStatuses.append(contentsOf: guessStatuses)
            return currentStatuses
        }

        // Checking if the elements in the guessedLetters array contain the corresponding status before returning the same status,
        // In order of precedence (inPosition -> notInPosition -> notInWord)
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
    
    var shareResultText: String? {
        // 1
        guard status == .won || status == .lost else { return nil }

        // 2
        let yellowBox = "\u{1F7E8}"
        let greenBox = "\u{1F7E9}"
        let grayBox = "\u{2B1B}"

        // 3
        var text = "6 GUESSES\n"
        if status == .won {
            text += "Turn \(currentGuess + 1)/\(maxGuesses)\n"
        } else {
            text += "Turn X/\(maxGuesses)\n"
        }
        // 4
        var statusString = ""
        for guess in guesses {
            // 5
            var nextStatus = ""
            for guessedLetter in guess.word {
                switch guessedLetter.status {
                    case .inPosition:
                        nextStatus += greenBox
                    case .notInPosition:
                        nextStatus += yellowBox
                    default:
                        nextStatus += grayBox
                }
                nextStatus += " "
            }
            // 6
            statusString += nextStatus + "\n"
        }
        // 7
        return text + statusString
    }
    
    func saveState() {
        let guessList = guesses.map { $0.status == .complete ? "\($0.letters)>" : $0.letters }
        let guessedKeys = guessList.joined()
        gameState = "\(targetWord)|\(guessedKeys)"
        print("Saving current game state: \(gameState)")
    }
    
    func loadState() {
        // 1
        print("Loading game state: \(gameState)")
        currentGuess = 0
        guesses = .init()
        guesses.append(WordGuess())
        status = .inprogress

        // 2
        let stateParts = gameState.split(separator: "|")
        // 3
        targetWord = String(stateParts[0])
        // 4
        guard stateParts.count > 1 else { return }
        let guessList = String(stateParts[1])
        // 5
        let letters = Array(guessList)
        for letter in letters {
            let newGuess = String(letter)
            addKey(letter: newGuess)
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
