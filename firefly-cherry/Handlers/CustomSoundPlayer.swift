//
//  CustomSoundPlayer.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 9/9/23.
//

import Foundation
import AVFoundation

class CustomSoundPlayer: ObservableObject {
    static let shared = CustomSoundPlayer()
    
    var player:AVAudioPlayer?
    var soundPath: URL? = nil
    var volume: Float = 0.5
    
    
    init(player: AVAudioPlayer? = nil, soundPath: URL? = nil) {
        self.player = player
        self.soundPath = soundPath
    }
    
    func setVolume(_ volume: Float) {
        self.player?.volume = volume
        self.volume = volume
    }
    
    func setSound(_ path:URL?) {
        self.soundPath = path
        
        if let soundPath = self.soundPath {
            player = try? AVAudioPlayer(contentsOf: soundPath, fileTypeHint: AVFileType.mp3.rawValue)
            player?.volume = self.volume
        }
    }
    
    func setPremadeSound(_ soundName:String) {
    
        if let bundlePath = Bundle.main.path(forResource: soundName + ".mp3", ofType:nil) {
                self.soundPath = URL(fileURLWithPath: bundlePath)
                player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: bundlePath), fileTypeHint: AVFileType.mp3.rawValue)
                player?.volume = self.volume
        }
    }
    
    func play() {
        player?.stop()
        player?.volume = self.volume
        player?.prepareToPlay()
        
        if self.soundPath != nil {
            player?.currentTime = 0
            player?.play()
        }
        
    }
    
    
    func stopAllSounds() {
        player?.stop()
    }
    
    
}
