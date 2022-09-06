//
//  ActivitySheetView.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 29/08/2022.
//

import SwiftUI

struct ActivitySheetView: UIViewControllerRepresentable {
    let activityItems: [Any]

    // Creating an instance of SwiftUI's UIViewController class 
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
