//
//  SplashScreenView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 31/08/2022.
//

import SwiftUI

struct SplashScreenView: View {
    
    // Declaring the initial variables
    @StateObject var csManager = AppColorScheme()
    @StateObject var game = SixGuesses()
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            
            // This if statement checks if the Splash Screen is already active in the application,
            // if so, then go straight to the main Game View immediately 
            if self.isActive {
                GameView()
                    .environmentObject(csManager)
                    .environmentObject(game)
                    .onAppear {
                        csManager.applyColorScheme()
                        playMusic(sound: "background-music", type: "mp3", numberOfLoops: -1)
                    }
                    .navigationViewStyle(.stack)
            } else {
                Image("splash-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            // On the appearance of the Splash Screen, create a 2-second delay period,
            // in which the Splash Screen will be shown before setting the boolean value to true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
