//
//  AppColorScheme.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 27/08/2022.
//

import SwiftUI

enum ColorScheme: Int {
    case system, light, dark
}

class AppColorScheme: ObservableObject {
    @AppStorage("colorScheme") var colorScheme: ColorScheme = .system {
        didSet {
            applyColorScheme()
        }
    }
    
    func applyColorScheme() {
        UIWindow.key?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: colorScheme.rawValue)!
    }
}
