//
//  AchievementsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 05/09/2022.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var stats: Statistics
    
    var body: some View {
        
        // Declaring the sub-arrays of the entire achievements array
        let games = achievementsList[0..<6]
        let wins = achievementsList[6..<12]
        let streak = achievementsList[12..<18]
        let attempt = achievementsList[18..<24]
        
        // Wrapping the content inside a ScrollView,
        // so that the player can view all the unlocked and locked achievements
        ScrollView {
            
            // Using a for-each loop to read through and display each achievement item,
            // along with their corresponding statuses (locked or unlocked)
            VStack (spacing: 20) {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 5)
                    .padding()
                    .frame(height: 100)
                    .overlay(
                        Text("Lifetime Achievements")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    )
                Group {
                    Text("Total Games Played")
                        .font(.title2)
                        .fontWeight(.bold)
                        .underline()
                        .textCase(.uppercase)
                    ForEach(games) { a in
                        AchievementItemView(achievement: a, isAchieved: checkGamesReq(req: a.requirement))
                    }
                }
                Divider()
                Group {
                    Text("Total Games Won")
                        .font(.title2)
                        .fontWeight(.bold)
                        .underline()
                        .textCase(.uppercase)
                    ForEach(wins) { a in
                        AchievementItemView(achievement: a, isAchieved: checkWinsReq(req: a.requirement))
                    }
                }
                Divider()
                Group {
                    Text("Highest Winning Streak")
                        .font(.title2)
                        .fontWeight(.bold)
                        .underline()
                        .textCase(.uppercase)
                    ForEach(streak) { a in
                        AchievementItemView(achievement: a, isAchieved: checkStreakReq(req: a.requirement))
                    }
                }
                Divider()
                Group {
                    Text("Win on guess attempt")
                        .font(.title2)
                        .fontWeight(.bold)
                        .underline()
                        .textCase(.uppercase)
                    ForEach(attempt) { a in
                        AchievementItemView(achievement: a, isAchieved: checkAttemptReq(lv: a.level))
                    }
                }
            }
        }
    }
    
    // These functions will compare the requirement attribute of each achievement,
    // and if they are equal or higher than the statistics, then return true (unlocked)
    func checkGamesReq(req: Int) -> Bool {
        return stats.gamesPlayed >= req
    }
    
    func checkWinsReq(req: Int) -> Bool {
        return stats.gamesWon >= req
    }
    
    func checkStreakReq(req: Int) -> Bool {
        return stats.maxWinStreak >= req
    }
    
    func checkAttemptReq(lv: Int) -> Bool {
        return stats.winRound[5 - lv] != 0
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(stats: Statistics(gameRecord: ""))
            
    }
}
