//
//  ResultView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
    
    //Declaring the initial variables
    @ObservedObject var game: SixGuesses
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    // If the player wins a round this particular congrats message is displayed,
                    // along with an uplifting music track similar to the victorious state
                    if game.status == .won {
                        Text(game.hardMode ? "You won on Hard Mode!" : "You guessed the word!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .textCase(.uppercase)
                            .padding()
                            .onAppear(perform: {
                                playMusic(sound: "win-music", type: "mp3", numberOfLoops: -1)
                            })
                        Image("well-done")
                            .resizable()
                            .frame(width: 300, height: 200)
                    } 
                    
                    // Otherwise, a regretful message is displayed instead,
                    // along with a dreary music track similar to the failure state
                    else {
                        Text(game.hardMode ? "You lost on Hard Mode!" : "You failed to guess the word in \(game.maxGuesses) attempts.")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .onAppear(perform: {
                                playMusic(sound: "lose-music", type: "mp3", numberOfLoops: -1)
                            })
                        Image("you-lost")
                            .resizable()
                            .frame(width: 300, height: 200)
                    }
                    
                    // In either case, the final answer is revealed to the player
                    Text("The word was \(game.targetWord).")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    
                    // Extra feature: A customized Google query containing the definition of the target word,
                    // redirecting them to an external website for the purpose of education
                    Link(destination: URL(string: "https://www.google.com/search?q=\(game.targetWord.lowercased())+meaning")!, label: {
                        Text("What does this word mean?")
                            .underline()
                    })
                    Spacer()
                    
                    // Extra feature: This vertical stack contains the "share your results" option, 
                    // allowing th player to send their round status to their friends
                    VStack {
                        Text("Share your results with friends!")
                            .font(.title2)
                            .fontWeight(.bold)
                        ShowResultView(game: game)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                            stopMusic(sound: "win-music", type: "mp3")
                            stopMusic(sound: "lose-music", type: "mp3")
                        } label: {
                            Text("**X**")
                        }
                    }
                }
            }
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

