//
//  KeyboardView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct KeyboardView: View {
    
    //Declaring the initial variables
    @ObservedObject var game: SixGuesses
    let keyboard = "QWERTYUIOP|ASDFGHJKL|<ZXCVBNM>"

    var body: some View {
        
        // Dividing the keyboard into separate rows based on where the "|" symbol is,
        // Then assigning each key to the KeyView with a background color
        let lines = keyboard.split(separator: "|")
        VStack {
            ForEach(lines, id: \.self) { line in
                HStack {
                    let keyArray = line.map { String($0) }
                    ForEach(keyArray, id: \.self) { key in
                        KeyView(game: game, key: key)
                            .background(game.colorForKey(key: key))
                            .accessibilityLabel(
                                game.statusForLetter(letter: key) == .unknown ?
                                key : "\(key) \(game.statusForLetter(letter: key).rawValue)"
                            )
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(game: SixGuesses()).padding()
    }
}
