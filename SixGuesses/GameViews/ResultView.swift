//
//  ResultView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var game: SixGuesses

    var body: some View {
        VStack {
            if game.status == .won {
                Text("You got it!")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                Text("Sorry you didn't get the word in \(game.maxGuesses) guesses.")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            Text("The word was \(game.targetWord).")
                .font(.title2)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultView(game: SixGuesses.wonGame())
            ResultView(game: SixGuesses.lostGame())
        }
    }
}

