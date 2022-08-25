//
//  MainMenuView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject var game = SixGuesses()
    @State private var showResults = false
    @State private var showStats = false
    
    var stats: Statistics

    
    var body: some View {
        ZStack {
//            Color.black.opacity(0.03)
            VStack {
                Spacer()
                Text("Welcome to 6 Guesses!")
                    .font(.system(size: 50, weight: .bold))
                Text("The WORDLE we all know and love, but BETTER")
                    .font(.system(size: 15, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                Spacer()
                Image("")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
                Spacer()
                NavigationLink {
                    GameView()
                } label: {
                    Text("Play")
                        .font(.system(size: 30))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 5)
                        }
                }
                NavigationLink {
                    StatisticsView(stats: Statistics(gameRecord: game.gameRecord))
                } label: {
                    Text("View Stats")
                        .font(.system(size: 30))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 5)
                        }
                }
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(stats: <#Statistics#>)
    }
}

