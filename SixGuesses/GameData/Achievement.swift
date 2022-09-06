//
//  Achievement.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 06/09/2022.
//

import Foundation
import SwiftUI

struct Achievement: Codable {
    var type: String
    var title: String
    var description: String
    var level: Int
    var requirement: Int
}

extension Achievement: Identifiable {
    var id: UUID {
        return UUID()
    }
}
