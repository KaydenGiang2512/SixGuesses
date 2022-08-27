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
            VStack {
                if game.status == .won {
                    Text("You got it!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .textCase(.uppercase)
                        .padding()
                        .onAppear(perform: {
                            playSound(sound: "win-music", type: "mp3", numberOfLoops: -1)
                        })
                } else {
                    Text("You failed to guess the word in \(game.maxGuesses) attempts.")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .onAppear(perform: {
                            playSound(sound: "lose-music", type: "mp3", numberOfLoops: -1)
                        })
                }
                Text("The word was \(game.targetWord).")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Link(destination: URL(string: "https://www.google.com/search?q=\(game.targetWord.lowercased())+meaning")!, label: {
                    Text("What does this word mean?")
                        .underline()
                })
                Spacer()
                NavigationLink {
                    StatisticsView(stats: Statistics(gameRecord: game.gameRecord))
                } label: {
                    Image(systemName: "chart.bar.fill")
                        .imageScale(.large)
                        .accessibilityLabel("Statistics")
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                        stopSound(sound: "win-music", type: "mp3")
                        stopSound(sound: "lose-music", type: "mp3")
                    } label: {
                        Text("**X**")
                            .foregroundColor(.black)
                    }
                }
            }
        }

    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ResultView(game: SixGuesses.wonGame())
//            ResultView(game: SixGuesses.lostGame())
        }
    }
}

