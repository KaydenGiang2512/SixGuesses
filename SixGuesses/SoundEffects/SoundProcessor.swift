//
//  SoundProcessor.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String, numberOfLoops: Int) {
    if let filePath = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            audioPlayer?.play()
            audioPlayer?.numberOfLoops = numberOfLoops
        } catch {
            print("Processing error: The specified file cannot be found/played!")
        }
    }
}
