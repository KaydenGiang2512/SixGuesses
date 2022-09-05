//
//  KeyView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct KeyView: View {
    
    // Declaring the initial variables
    @ObservedObject var game: SixGuesses
    var key: String

    var body: some View {
        
        // Making each keyboard key as an indivudal button with its own symbol (letter or special character), 
        // which also makes a cool clicking sound when activated
        Button {
            game.addKey(letter: key)
            playSFX(sound: "key-click", type: "mp3")
        } label: {
            
            // Switch statement to add the appropriate symbols to the regular letter keys,
            // as well as the special keys (enter button and delete button)
            switch key {
                case "<":
                    Image(systemName: "delete.backward")
                case ">":
                    Image(systemName: "return")
                default:
                    Text(key)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(maxWidth: .infinity)
            }
        }
        .padding(6)
        .background {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke()
        }
        .foregroundColor(Color(UIColor.label))
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SixGuesses()
        Group {
            KeyView(game: game, key: "<")
            KeyView(game: game, key: ">")
        }
    }
}
