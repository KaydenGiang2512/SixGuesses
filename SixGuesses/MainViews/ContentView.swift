//
//  ContentView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 18/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    // Declaring the color scheme variable as soon as the application loads
    @StateObject var csManager = AppColorScheme()
    
    var body: some View {
        SplashScreenView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
