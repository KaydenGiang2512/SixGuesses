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
    @State private var showStats = false
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("6 Chances to Guess the Word!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(.white)
                BoardView(game: game)
                KeyboardView(game: game)
                    .padding(5)
                Spacer()
                HStack {
                    NavigationLink {
                        InstructionsView()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .imageScale(.large)
                            .accessibilityLabel("Instructions")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button {
                        game.newGame()
                        playSound(sound: "background-music", type: "mp3", numberOfLoops: -1)
                    } label: {
                        Text("New Game")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
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
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
