//
//  GuessView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct GuessView: View {
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
          // 1
          .foregroundColor(Color(UIColor.systemBackground))
          // 2
          .frame(width: size, height: size)
          // 3
          .background(letter.statusColor)
          // 4
          .cornerRadius(size / 5.0)
            // 1
          .rotation3DEffect(
            // 2
            .degrees(letter.status == .unknown ? 0 : 180),
            // 3
            axis: (x: 0.0, y: 1.0, z: 0.0)
          )
          // 4
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
