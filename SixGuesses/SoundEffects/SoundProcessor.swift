//
//  SoundProcessor.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
var musicPlayer: AVAudioPlayer?

func playMusic(sound: String, type: String, numberOfLoops: Int) {
    if let filePath = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            musicPlayer?.play()
            musicPlayer?.numberOfLoops = numberOfLoops
        } catch {
            print("Processing error: The specified file cannot be found/played!")
        }
    }
}

func stopMusic(sound: String, type: String) {
    if let filePath = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            musicPlayer?.stop()
        } catch {
            print("Processing error: The specified file cannot be found/stopped!")
        }
    }
}

func playSFX(sound: String, type: String) {
    if let filePath = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            audioPlayer?.play()
        } catch {
            print("Processing error: The specified file cannot be found/played!")
        }
    }
}
