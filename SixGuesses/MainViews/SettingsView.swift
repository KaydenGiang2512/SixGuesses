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
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
