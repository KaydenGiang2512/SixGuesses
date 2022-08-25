//
//  ActionView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct ActionView: View {
  @Binding var showStats: Bool
  @ObservedObject var game: SixGuesses

  var body: some View {
    HStack {
      Spacer()
      Button {
        game.newGame()
      } label: {
        Image(systemName: "plus")
          .imageScale(.large)
          .accessibilityLabel("New Game")
      }
      .disabled(game.status == .inprogress || game.status == .new)
    }.padding(7)
  }
}

struct ActionView_Previews: PreviewProvider {
  static var previews: some View {
    ActionView(
      showStats: .constant(false),
      game: SixGuesses.inProgressGame()
    )
  }
}
