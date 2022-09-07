//
//  AchievementItemView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 05/09/2022.
//

import SwiftUI

struct AchievementItemView: View {
    
    // Declaring the initial variables
    @State var achievement: Achievement
    @State var isAchieved: Bool
    let colorList = [Color.teal, Color.blue, Color.green, Color.yellow, Color.orange, Color.red]
    
    var body: some View {
        HStack {
            
            // Displaying the name and description of a particular achievement item,
            // based on the pre-written content in the Achievements.json file
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
        
        // Adding a background fill to each achievement item based on their level of difficulty
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorList[achievement.level])
                .opacity(0.5)
        )
        
        // Toggling a blur overlay to indicate whether an achievement is earned or not
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
