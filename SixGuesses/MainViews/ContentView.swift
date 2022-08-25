//
//  ContentView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 18/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = SixGuesses()
    @State private var showResults = false
    @State private var showStats = false

    var body: some View {
        WelcomeView()
        VStack {
          Text("6 Chances to Guess the Word!")
            .font(.title)
            .accessibilityAddTraits(.isHeader)
          BoardView(game: game)
          KeyboardView(game: game)
            .padding(5)
          ActionView(
            showStats: $showStats,
            game: game
          )
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
