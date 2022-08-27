//
//  SettingsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var csManager: AppColorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Toggle App Themes")
                Picker("Display mode", selection: $csManager.colorScheme) {
                    Text("Light").tag(ColorScheme.light)
                    Text("Dark").tag(ColorScheme.dark)
                    Text("System").tag(ColorScheme.system)
                }
                .pickerStyle(.segmented)
                Spacer()
            }
            .navigationTitle("Game Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("**X**")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
