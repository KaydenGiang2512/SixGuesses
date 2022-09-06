//
//  GameView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct GameView: View {
    
    // Declaring the initial variables
    @EnvironmentObject var game: SixGuesses
    @State private var showResults = false
    @State private var showStats = false
    @State private var disabledButton = true
    @Environment(\.scenePhase) var scenePhase
    
    // Declaring the AppStorage variable game state to save/load current state
    @AppStorage("GameState") var gameState = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor.opacity(0.5).edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    // This horizontal stack is the menu bar of this application,
                    // so no need for a separate menu view since everything is neatly incorporated
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
                            StatisticsView(stats: Statistics(gameRecord: game.gameRecord))
                        } label: {
                            Image(systemName: "chart.bar.fill")
                                .imageScale(.large)
                                .accessibilityLabel("Statistics")
                                .foregroundColor(.white)
                        }
                        Spacer()
                        NavigationLink {
                            AchievementsView(stats: Statistics(gameRecord: game.gameRecord))
                        } label: {
                            Image(systemName: "star.circle.fill")
                                .imageScale(.large)
                                .accessibilityLabel("Achievements")
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
                    .padding(.all)
                    Spacer()
                    
                    // This section contains the main game view
                    Text("6 GUESSES")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(
                            game.hardMode
                            ? LinearGradient(
                                colors: [.red],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            : LinearGradient(
                                colors: [.orange, .blue, .green, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .padding(.all)
                        .border(.foreground)
                    BoardView(game: game)
                    KeyboardView(game: game)
                        .padding(5)
                    Spacer()
                    
                    // This horizontal stack is the bottom action bar of this application,
                    // where the player can access the settings along with a "New Game" button
                    HStack {
                        Spacer()
                        Button {
                            game.newGame()
                            disabledButton = true
                            playMusic(sound: "background-music", type: "mp3", numberOfLoops: -1)
                        } label: {
                            Text("New Game")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(disabledButton ? .gray.opacity(0.75) : .white)
                        }
                        .disabled((game.status == .inprogress || game.status == .new) && disabledButton)
                    }
                    .padding(.horizontal)
                }
                
                // Checking if the boolean value showResults is true or not.
                // If so, display the Results View towards the player
                .sheet(isPresented: $showResults) {
                    ResultView(game: game)
                }
                
                // Monitoring the change in game status, and play the appropriate sound effect
                .onChange(of: game.status) { newStatus in
                                            
                    // In the case where the player either wins or lose a round,
                    // the results view is shown with the corresponding sound and message
                    if newStatus == .won || newStatus == .lost {
                        if newStatus == .won {
                            playSFX(sound: "win-sfx", type: "mp3")
                        } else if newStatus == .lost {
                            playSFX(sound: "lose-sfx", type: "mp3")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showResults = true
                        }
                        disabledButton = false
                    }
                }
                .frame(alignment: .top)
                .padding(.bottom, 10)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                
                // Monitoring the changes in the app scenes (active, inactive or background)
                .onChange(of: scenePhase) { newPhase in
                                           
                    // Saving game state when the scene phase is either inactive or in background
                    if newPhase == .background || newPhase == .inactive {
                        game.saveState()
                    }
                }
            }
        }
        
        // Loading the current game state if it's not empty so that users can continue
        .onAppear {
            if game.status == .new && !game.gameState.isEmpty {
                game.loadState()
        }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
