//
//  MainMenuView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject var game = SixGuesses()
    
    var body: some View {
        ZStack {
//            Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255)
//                .edgesIgnoringSafeArea(.all)
            NavigationView {
                ZStack {
                    Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255, opacity: 0.5)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
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
                        Spacer()
                        NavigationLink {
                            GameView()
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.blue)
                                .frame(width: 250, height: 75)
                                .overlay {
                                    Text("Play Now")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .padding()
                                        .foregroundColor(.white)

                                }
                        }
                        Spacer()
                        NavigationLink {
                            StatisticsView(stats: Statistics(gameRecord: game.gameRecord))
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.blue)
                                .frame(width: 250, height: 75)
                                .overlay {
                                    Text("Game Stats")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .padding()
                                        .foregroundColor(.white)
                                    

                                }
                        }
                    }
                }
            }

        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

