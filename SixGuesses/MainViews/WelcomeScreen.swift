//
//  WelcomeScreen.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct WelcomeScreen: View {
    @Binding var active: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.03)
            VStack {
                Spacer()
                Text("Welcome to 6 Guesses!")
                    .font(.system(size: 50, weight: .bold))
                Text("The WORDLE game we all know and love, but BETTER")
                    .font(.system(size: 15, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                Spacer()
                Image("")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
                Spacer()
                Button(action: {
                    active = false
                }, label: {
                    Capsule()
                     .fill(Color.black)
                     .padding(8)
                     .frame(height:80)
                     .overlay(Text("Get Started")
                     .font(.system(.title3, design: .rounded))
                     .fontWeight(.bold)
                     .foregroundColor(.white))
                })
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(active: .constant(true))
    }
}

