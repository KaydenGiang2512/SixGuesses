//
//  ShowResultView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 29/08/2022.
//

import SwiftUI

struct ShowResultView: View {
    @ObservedObject var game: SixGuesses
    @State var showShare = false
    
    var body: some View {
        Group {
            if let text = game.shareResultText {
                Text(text)
                    .foregroundColor(Color.green)
                    .frame(maxWidth: .infinity)
                HStack {
                    Button {
                        showShare = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
            } else {
                Text("Game Not Complete")
            }
        }
        .font(.title3)
        .multilineTextAlignment(.center)
        .sheet(isPresented: $showShare) {
            let text = game.shareResultText ?? ""
            ActivitySheetView(activityItems: [text])
        }
    }
}

struct ShowResultView_Previews: PreviewProvider {
    static var previews: some View {
        ShowResultView(game: SixGuesses.wonGame())
    }
}
