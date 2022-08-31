//
//  Statistics.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import Foundation

struct Statistics {
    var gameRecord: String

    var gamesPlayed: Int {
        gameRecord.count
    }

    var gamesWon: Int {
        gameRecord.filter { $0 != "L" }.count
    }

    var percentageWon: Int {
        guard gamesPlayed > 0 else { return 0 }
        return Int((Double(gamesWon) / Double(gamesPlayed) * 100.0).rounded())
    }

    var currentWinStreak: Int {
        return gameRecord.reversed().firstIndex(of: "L") ?? gameRecord.count
    }

    var maxWinStreak: Int {
        let games = Array(gameRecord) // gameRecord.map { $0 }
        var maxStreak = 0
        var currentStreak = 0
        for game in games {
            if game != "L" {
                currentStreak += 1
            } else {
                maxStreak = currentStreak
                currentStreak = 0
            }
        }
        if currentStreak > maxStreak {
            maxStreak = currentStreak
        }
        return maxStreak
    }

    var winRound: [Int] {
        let win1 = gameRecord.filter { $0 == "1" }.count
        let win2 = gameRecord.filter { $0 == "2" }.count
        let win3 = gameRecord.filter { $0 == "3" }.count
        let win4 = gameRecord.filter { $0 == "4" }.count
        let win5 = gameRecord.filter { $0 == "5" }.count
        let win6 = gameRecord.filter { $0 == "6" }.count

        return [win1, win2, win3, win4, win5, win6]
    }
}
