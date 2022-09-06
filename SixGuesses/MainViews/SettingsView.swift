//
//  SettingsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import SwiftUI

struct SettingsView: View {
    
    // Declaring the initial variables
    @EnvironmentObject var csManager: AppColorScheme
    @EnvironmentObject var game: SixGuesses
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Creating a section element to add a footer to the Hard Mode toggle button,
                // to briefly explain how Hard Mode will work and how to beat it
                Section(footer: Text("When Hard Mode is enabled, only the correctly placed letters/not-in-word letters will be indicated! (Green or Gray only)")
                        .foregroundColor(.gray.opacity(0.75))) {
                    VStack(alignment: .leading) {
                        Toggle("Hard Mode", isOn: $game.hardMode)
                        Divider()
                    }
                }
                .padding(.bottom)
                
                // Creating a picker element with 3 options to toggle between light mode,
                // dark mode or based on the default system preferences
                Text("Toggle App Themes")
                Picker("Display mode", selection: $csManager.colorScheme) {
                    Text("Light").tag(ColorScheme.light)
                    Text("Dark").tag(ColorScheme.dark)
                    Text("System").tag(ColorScheme.unspecified)
                }
                .pickerStyle(.segmented)
                Spacer()
            }
            .navigationBarTitle("Game Settings")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
