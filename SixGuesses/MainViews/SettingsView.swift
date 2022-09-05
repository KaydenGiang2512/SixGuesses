//
//  SettingsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var csManager: AppColorScheme
    @EnvironmentObject var game: SixGuesses
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Section(footer: Text("When Hard Mode is enabled, only the correctly placed letters will be indicated!")
                        .foregroundColor(.gray.opacity(0.75))) {
                    VStack(alignment: .leading) {
                        Toggle("Hard Mode", isOn: $game.hardMode)
                        Divider()
                    }
                }
                .padding(.vertical)
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
