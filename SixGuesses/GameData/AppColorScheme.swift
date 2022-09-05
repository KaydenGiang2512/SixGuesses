//
//  AppColorScheme.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 27/08/2022.
//

import SwiftUI

// Creating an enum containing the different schemes that the application will toggle between
enum ColorScheme: Int {
    case unspecified, light, dark
}

// Creating a class to implement the different schemes as well as storing it in UserDefaults
class AppColorScheme: ObservableObject {
    @AppStorage("colorScheme") var colorScheme: ColorScheme = .unspecified {
        didSet {
            applyColorScheme()
        }
    }
    
    //This function sets the color scheme according to user input, thereby overriding the default styles
    func applyColorScheme() {
        UIWindow.key?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: colorScheme.rawValue)!
    }
}
