//
//  SplashScreenView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 31/08/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var csManager = AppColorScheme()
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                GameView()
                    .environmentObject(csManager)
                    .onAppear {
                        csManager.applyColorScheme()
                    }
                    .navigationViewStyle(.stack)
            } else {
                Image("splash-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
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
