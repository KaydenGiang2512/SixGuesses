//
//  SoundProcessor.swift
//  SixGuesses
//
//  Created by Khanh Giang Nhat on 26/08/2022.
//

import AVFoundation

// Declaring the initial variables
var audioPlayer: AVAudioPlayer?
var musicPlayer: AVAudioPlayer?

// This function will try to find the music files, 
// then plays the song on command through AVAudioPlayer's built-in play method 
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

// This function will try to find the music files, 
// then stops the song on command through AVAudioPlayer's built-in stop method 
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

// This function will try to find the sound effect files, 
// then plays the sound on command through AVAudioPlayer's built-in play method 
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
