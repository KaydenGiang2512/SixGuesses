//
//  AchievementsProcessor.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 06/09/2022.
//

import Foundation

var achievementsList = decodeJsonFromJsonFile(jsonFileName: "Achievements.json")

// How to decode a json file into a struct
func decodeJsonFromJsonFile(jsonFileName: String) -> [Achievement] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Achievement].self, from: data)
                return decoded
            } catch let error {
                fatalError("Unable to parse and decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Failed to load the \(jsonFileName) file")
    }
    return [ ] as [Achievement]
}
