//
//  GuessView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct GuessView: View {
  
  // Declaring the initial variables
  var letter: GuessedLetter
  var size: Double
  var index: Int

  var body: some View {
    Text(letter.letter)
          .rotation3DEffect(
            .degrees(letter.status == .unknown ? 0 : -180),
            axis: (x: 0.0, y: 1.0, z: 0.0)
          )
          .font(.title)
    
          // Setting the font's foreground color to the system background,
          // allowing for easier color scheme adaptability
          .foregroundColor(Color(UIColor.systemBackground))
    
          // Setting the frame by width and height of the passed value
          .frame(width: size, height: size)
    
          // Setting the background color of each letter box to its corresponding status color
          .background(letter.statusColor)
    
          // Adding the corner radius property to give the tile a smooth and polished aesthetic
          .cornerRadius(size / 5.0)
    
            // Using the rotation3DEffect to flexibly adjust the axis of the animation plane
          .rotation3DEffect(
            
            // Unless the letter status is unknown, rotate that letter tile by 180 degrees
            .degrees(letter.status == .unknown ? 0 : 180),
            
            // Specifying the rotation axis throughout this animation (y-axis in this case)
            axis: (x: 0.0, y: 1.0, z: 0.0)
          )
    
          // Prompting SwiftUI to animate this view on any changes occuring on the letter status,
          // and ensures that it is happening at constant speed from start to finish
          .animation(
            .linear(duration: 1.0).delay(0.1 * Double(index)),
            value: letter.status
          )
  }
}

struct GuessView_Previews: PreviewProvider {
  static var previews: some View {
    let guess = GuessedLetter(letter: "S", status: .inPosition)
    GuessView(letter: guess, size: 50, index: 1)
  }
}
