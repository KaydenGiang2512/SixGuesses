//
//  ShowResultView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 29/08/2022.
//

import SwiftUI

struct ShowResultView: View {
    
    // Declaring the initial variables
    @ObservedObject var game: SixGuesses
    @State var showShare = false
    
    var body: some View {
        Group {
            
            // Showing the summary text for the player to see and interact with,
            // via a standard share button below
            if let text = game.shareResultText {
                Text(text)
                    .foregroundColor(Color.green)
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
        
        // Checking for the boolean value showShare,
        // In the case that it is true, display the share sheet to the player
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
