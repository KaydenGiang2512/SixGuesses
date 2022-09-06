//
//  AchievementItemView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 05/09/2022.
//

import SwiftUI

struct AchievementItemView: View {
    @State var achievement: Achievement
    @State var isAchieved: Bool
    let colorList = [Color.teal, Color.blue, Color.green, Color.yellow, Color.orange, Color.red]
    
    var body: some View {
        HStack {
            VStack {
                Text(achievement.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                Text(achievement.description)
                    .font(.subheadline)
            }
        }
        .frame(width: 350)
        .padding(.all)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorList[achievement.level])
                .opacity(0.5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .opacity(isAchieved ? 0 : 0.75)
        )
    }
}

struct AchievementItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AchievementItemView(achievement: achievementsList[0], isAchieved: true)
            AchievementItemView(achievement: achievementsList[1], isAchieved: false)
        }
    }
}
