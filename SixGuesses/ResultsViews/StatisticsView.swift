//
//  StatisticsView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct StatisticsView: View {
  var stats: Statistics

  var body: some View {
      VStack(spacing: 15.0) {
        VStack {
          Text("All-time Statistics")
            .font(.title)
            .fontWeight(.bold)
          Text("Games played: \(stats.gamesPlayed) ") +
          Text("Games won: \(stats.gamesWon) (\(stats.percentageWon) %)")
          Text("Win Streak: \(stats.currentWinStreak) ") +
          Text("Longest Streak: \(stats.maxWinStreak)")
        }
        Spacer()
        // 1
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
                        Rectangle()
                            .frame(width: barLength,
                                height: 20.0
                            )
                        Text("\(barCount)")
                    }
            }
            Spacer()
            
        }
      }

  }
}

struct StatisticsView_Previews: PreviewProvider {
  static var previews: some View {
    StatisticsView(stats: Statistics(gameRecord: ""))
  }
}
