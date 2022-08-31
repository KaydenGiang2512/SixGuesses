//
//  ContentView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 18/08/2022.
//

import SwiftUI

struct ContentView: View {
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
