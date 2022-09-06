//
//  InstructionsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import SwiftUI

struct InstructionsView: View {
    
    // Declaring the dismiss environment variable as our "x" button
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            
            // Adding a multiline text paragraph and aligns it to the left edge of the view
            VStack(alignment: .leading) {
                Text(
"""
Guess the **WORDLE** in 6 attempts.

Each guess must contain a valid 5-letter word, so don't make up random ones :)). Hit the **'\(Image(systemName: "return"))'** button to submit.

After each guess, the color of the tiles will change to indicate your current status of that word.
"""
                )
                Divider()
                Spacer()
                Text("**Examples**:")
                    .font(.system(size: 20))
                    .underline()
                
                // Adding illustrations of how to play the SixGuesses game
                VStack(alignment: .leading) {
                    Image("Weary")
                        .resizable()
                        .scaledToFit()
                    Text("The letter **W** is in the word and is in the correct spot.")
                    Image("Pills")
                        .resizable()
                        .scaledToFit()
                    Text("The letter **I** is in the word but is in the wrong spot.")
                    Image("Vague")
                        .resizable()
                        .scaledToFit()
                    Text("The letter **U** is not a letter present in the word.")
                }
                Divider()
                Text("For a new WORDLE, just hit the **'New Game'** button!")
                    .font(.system(size: 25))
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: .center)
                Spacer()
            }
            .frame(width: 300)
            .navigationTitle("HOW TO PLAY")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
