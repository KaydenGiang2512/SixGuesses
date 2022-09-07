//
//  BoardView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct BoardView: View {
    
    // Declaring the initial variables
    @ObservedObject var game: SixGuesses
    @State var showResult = false

    var unusedGuesses: Int {
        let remainingGuesses = game.maxGuesses - game.guesses.count
        if remainingGuesses < 0 {
            return 0
        }
        return remainingGuesses
    }

    var body: some View {
        VStack {
      
            // For-each loop to go through all existing guesses in as a binding
            ForEach($game.guesses) { guess in
                              
                // Displaying each individual guess via the CurrentGuessView,
                // by passing in the binding as well as the word length constant
                CurrentGuessView(guess: guess, wordLength: game.wordLength)
            }
      
            // Loop through the remaining empty slots (unused guesses)
            ForEach(0..<unusedGuesses, id: \.self) { _ in
                                              
                // For each unsued guess, display the empty row also using the CurrentGuessView,
                // by passing in the blank guess as well as the word length constant
                CurrentGuessView(guess: .constant(WordGuess()), wordLength: game.wordLength)
            }
        }
        .sheet(isPresented: $showResult) {
            ResultView(game: game)
        }
        .padding(10)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(game: SixGuesses.inProgressGame())
    }
}
