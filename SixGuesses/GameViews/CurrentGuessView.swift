//
//  CurrentGuessView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct CurrentGuessView: View {
    @Binding var guess: WordGuess
    var wordLength: Int

    var unguessedLetters: Int {
      wordLength - guess.word.count
    }
    @State var shakeOffset = 0.0


    var body: some View {
        // 1
        GeometryReader { proxy in
          HStack {
            Spacer()
            // 2
            let width = (proxy.size.width - 40) / 5 * 0.8
            // 3
            ForEach(guess.word.indices, id: \.self) { index in
              // 4
              let letter = guess.word[index]
              GuessView(letter: letter, size: width, index: index)
                    .accessibilityLabel(
                        letter.status == .unknown ? letter.letter : "\(letter.letter) \(letter.status.rawValue)"
                    )

            }
            // 5
            ForEach(0..<unguessedLetters, id: \.self) { _ in
              EmptyView(size: width)
            }
            Spacer()
          }
            .padding(5.0)
            // 1
            .offset(x: shakeOffset)
            // 2
            .onChange(of: guess.status) { newValue in
            // 3
                if newValue == .invalidWord {
                    withAnimation(.linear(duration: 0.1).repeatCount(3)) {
                        shakeOffset = -15.0
                    }
                // 4
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.linear(duration: 0.1).repeatCount(3)) {
                            shakeOffset = 0.0
                            // 5
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                guess.status = .pending
                            }
                        }
                    }
                }
            }
          .overlay(
            Group {
              if guess.status == .invalidWord {
                Text("Word not in dictionary!")
                  .foregroundColor(.red)
                  .fontWeight(.bold)
                  .background(Color(UIColor.systemBackground))
                  .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                      guess.status = .pending
                    }
                  }
              }
            }
          )
        }
      }
}

struct CurrentGuessView_Previews: PreviewProvider {
  static var previews: some View {
    let guessedLetter = GuessedLetter(letter: "S", status: .inPosition)
    let guessedLetter2 = GuessedLetter(letter: "A", status: .notInPosition)
    let guess = WordGuess(
      word: [guessedLetter, guessedLetter2],
      status: .pending
    )
    CurrentGuessView(
      guess: .constant(guess),
      wordLength: 5
    )
  }
}
