//
//  StatisticsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var stats: Statistics
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack(spacing: 15.0) {
            VStack {
                Text("All-time Statistics")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical)
                Text("Total games played: \(stats.gamesPlayed)")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.vertical)
                    .frame(width: 350)
                    .border(.foreground)
                Text("Total games won: \(stats.gamesWon)")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.vertical)
                    .frame(width: 350)
                    .border(.foreground)
                Text("Winning percentage: \(stats.percentageWon)%")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.vertical)
                    .frame(width: 350)
                    .border(.foreground)
                Text("Current Winning Streak: \(stats.currentWinStreak)")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.vertical)
                    .frame(width: 350)
                    .border(.foreground)
                Text("Longest Winning Streak: \(stats.maxWinStreak)")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.vertical)
                    .frame(width: 350)
                    .border(.foreground)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Winning Guess Distribution")
                    .font(.title)
                    .fontWeight(.bold)
                // 2
                let maxDistribution = Double(stats.winRound.max() ?? 1)
                // 3
                ForEach(stats.winRound.indices, id: \.self) { index in
                    // 4
                    let barCount = stats.winRound[index]
                    let barLength = barCount > 0 ?
                    Double(barCount) / maxDistribution * 250.0 : 1
                    HStack {
                        // 5
                        Text("\(index + 1)")
                            .fontWeight(.semibold)
                        Rectangle()
                            .frame(width: barLength,
                                height: 20.0
                            )
                            .foregroundColor(.blue)
                        Text("\(barCount) time(s)")
                    }
                }
            }
            Spacer()
            Button {
                stats.gameRecord = ""
                UserDefaults.standard.removeObject(forKey: "GameRecord")
            } label: {
                Text("Reset Game Stats")
                    .font(.title2)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
      static var previews: some View {
          StatisticsView(stats: Statistics(gameRecord: ""))
      }
}
