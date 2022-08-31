//
//  ResultView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
    @ObservedObject var game: SixGuesses
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if game.status == .won {
                        Text("You got it!")
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
                    } else {
                        Text("You failed to guess the word in \(game.maxGuesses) attempts.")
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
                    Text("The word was \(game.targetWord).")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    Link(destination: URL(string: "https://www.google.com/search?q=\(game.targetWord.lowercased())+meaning")!, label: {
                        Text("What does this word mean?")
                            .underline()
                    })
                    Spacer()
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

