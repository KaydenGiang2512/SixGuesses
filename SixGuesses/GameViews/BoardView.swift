//
//  BoardView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct BoardView: View {
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
      // 1
      ForEach($game.guesses) { guess in
        // 2
        CurrentGuessView(guess: guess, wordLength: game.wordLength)
      }
      // 3
      ForEach(0..<unusedGuesses, id: \.self) { _ in
        // 4
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
