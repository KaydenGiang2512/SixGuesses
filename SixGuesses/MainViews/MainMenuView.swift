//
//  MainMenuView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct MainMenuView: View {
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255, opacity: 0.4)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        HStack {
                            NavigationLink {
                                SettingsView()
                            } label: {
                              Image(systemName: "gear")
                                .imageScale(.large)
                                .accessibilityLabel("Settings")
                                .foregroundColor(.black)
                            }
                            Spacer()
                            NavigationLink {
                                InstructionsView()
                            } label: {
                                Image(systemName: "questionmark.circle")
                                    .imageScale(.large)
                                    .accessibilityLabel("Instructions")
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(.horizontal)
                        Spacer()
                        Text("6 GUESSES")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.red, .blue, .green, .yellow],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        Image("thinking-man")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Spacer()
                        NavigationLink {
                            GameView()
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.blue)
                                .frame(width: 250, height: 75)
                                .overlay {
                                    Text("New Game")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .padding()
                                        .foregroundColor(.white)

                                }
                        }
                        NavigationLink {
                            GameView()
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.blue)
                                .frame(width: 250, height: 75)
                                .overlay {
                                    Text("Resume game")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .padding()
                                        .foregroundColor(.white)
                                }
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
        }
        .onAppear(perform: {
            playSound(sound: "background-music", type: "mp3", numberOfLoops: -1)
        })
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

