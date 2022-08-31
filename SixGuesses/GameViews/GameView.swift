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
//    @AppStorage("GameState") var gameState = ""
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor.opacity(0.5).edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gear")
                            .imageScale(.large)
                            .accessibilityLabel("Settings")
                            .foregroundColor(.white)
                        }
                        Spacer()
                        NavigationLink {
                            InstructionsView()
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .imageScale(.large)
                                .accessibilityLabel("Instructions")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    Text("6 GUESSES")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red, .blue, .green, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    BoardView(game: game)
                    KeyboardView(game: game)
                        .padding(5)
                    Spacer()
                    HStack {
                        NavigationLink {
                            StatisticsView(stats: Statistics(gameRecord: game.gameRecord))
                        } label: {
                            Image(systemName: "chart.bar.fill")
                                .imageScale(.large)
                                .accessibilityLabel("Statistics")
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button {
                            game.newGame()
                            playMusic(sound: "background-music", type: "mp3", numberOfLoops: -1)
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
                        if newStatus == .won {
                            playSFX(sound: "win-sfx", type: "mp3")
                        } else if newStatus == .lost {
                            playSFX(sound: "lose-sfx", type: "mp3")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showResults = true
                        }
                    }
                }
                .frame(alignment: .top)
                .padding([.bottom], 10)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                // 1
                .onChange(of: scenePhase) { newPhase in
                    // 2
                    if newPhase == .active {
                        if game.status == .inprogress && !game.gameState.isEmpty {
                            game.loadState()
                        }
                    }
                    // 3
                    if newPhase == .background || newPhase == .inactive {
                        game.saveState()
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
