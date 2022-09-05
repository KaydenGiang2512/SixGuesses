//
//  CurrentGuessView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct CurrentGuessView: View {
    
    // Declaring the initial variables
    @Binding var guess: WordGuess
    var wordLength: Int

    var unguessedLetters: Int {
      wordLength - guess.word.count
    }
    
    @State var shakeOffset = 0.0


    var body: some View {
        
        // Wrap the whole view with Geometry Reader to access the size of the view via the proxy
        GeometryReader { proxy in
          HStack {
            Spacer()
              
            // Calculating the width of each letter with respect to the entire view width
            let width = (proxy.size.width - 40) / 5 * 0.8
              
            // Using a for-loop to go through each letter in the guess along with specifying an id,
            // since each letter in the word is unique
            ForEach(guess.word.indices, id: \.self) { index in
                                                     
              // 4 Assigning each letter at each individual index to a letter constant,
              // then use the GuessView to display them in a neat layout from left to right
              let letter = guess.word[index]
              GuessView(letter: letter, size: width, index: index)
                    .accessibilityLabel(
                        letter.status == .unknown ? letter.letter : "\(letter.letter) \(letter.status.rawValue)"
                    )

            }
              
            // Using the EmptyView to indicate the unused slots (unguessed letters)
            ForEach(0..<unguessedLetters, id: \.self) { _ in
              EmptyView(size: width)
            }
            Spacer()
          }
            .padding(5.0)
                        
            // Applying an offset value to the view
            .offset(x: shakeOffset)
                        
            // Telling SwiftUI to monitor any changes in the guess status to perform the animation
            .onChange(of: guess.status) { newValue in
                                         
            // In the case of an invalid word, we use the withAnimation function to animate the occurance
                if newValue == .invalidWord {
                    withAnimation(.linear(duration: 0.1).repeatCount(3)) {
                        shakeOffset = -15.0
                    }
                    
                // Applying a 3-second delay before resetting the position of the view to its original spot
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.linear(duration: 0.1).repeatCount(3)) {
                            shakeOffset = 0.0
                            
                            // Wait for 1 additional second before setting the guess status back to pending
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                guess.status = .pending
                            }
                        }
                    }
                }
            }
                        
          // Adding an overlay text field that will only be invoked when the player has submitted an unrecognized word,
          // before dismissing the guess and set the guess status to pending
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
