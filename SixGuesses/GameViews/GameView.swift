//
//  GameView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct GameView: View {
    @StateObject var game = SixGuesses()
    @State private var showResults = false
    
    var body: some View {
        VStack {
          Text("6 Chances to Guess the Word!")
            .font(.title)
            .accessibilityAddTraits(.isHeader)
          BoardView(game: game)
          KeyboardView(game: game)
            .padding(5)
        }
        .sheet(isPresented: $showResults) {
            ResultView(game: game)
        }
        .onChange(of: game.status) { newStatus in
          // 2
          if newStatus == .won || newStatus == .lost {
            // 3
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
              showResults = true
            }
          }
        }
        .frame(alignment: .top)
        .padding([.bottom], 10)

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
