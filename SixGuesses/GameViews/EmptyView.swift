//
//  EmptyView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 25/08/2022.
//

import SwiftUI

struct EmptyView: View {
  
  // Declaring the initial variable
  var size: Double

  var body: some View {
    
    // Creating a rounded rectangle shape, which will become the box for each letter
    RoundedRectangle(cornerRadius: size / 5.0)
      .stroke(Color(UIColor.label))
      .frame(width: size, height: size)
  }
}

struct EmptyView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyView(size: 50.0)
  }
}
