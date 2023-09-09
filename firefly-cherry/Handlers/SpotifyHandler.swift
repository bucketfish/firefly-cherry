//
//  SpotifyHandler.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import Foundation
import SwiftUI

func getPlaySongAccess() {
    let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
    let accessEnabled = AXIsProcessTrustedWithOptions(options)
    
    
    if !accessEnabled {
        print("Access Not Enabled")
    } else {
        print("Access Granted")
    }
}

func getSongName(completion: @escaping (NSAppleEventDescriptor)->()) {
    let myAppleScript = """
        if application "Spotify" is running then
            tell application "Spotify"
                set c to current track
                return {(get name of current track) as text & " · " & (get artist of current track) as text,  get artwork url of current track as text}
            end tell
        else
            return "NOTRUNNING"
        end if
    
    """
    var error: NSDictionary?
    
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            let outputString = scriptObject.executeAndReturnError(&error)
            completion(outputString)
        }
    }
    
}

func toggleIsPlaying(completion: @escaping (NSAppleEventDescriptor)->()) {
    let myAppleScript = """
        using terms from application "Spotify"
            if player state of application "Spotify" is paused then
                tell application "Spotify" to play
                return true
            else
                tell application "Spotify" to pause
                return false
            end if
        end using terms from
        """
    
    var error: NSDictionary?
    
    
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            let outputString = scriptObject.executeAndReturnError(&error)
            completion(outputString)
        }
    }
}




func nextSong(completion: @escaping ()->()) {
    let myAppleScript = """
        tell application "Spotify"
            next track
        end tell
        """
    
    var error: NSDictionary?
    
    
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            let outputString = scriptObject.executeAndReturnError(&error)
            completion()
        }
    }
}


func prevSong(completion: @escaping ()->()) {
    let myAppleScript = """
        tell application "Spotify"
            previous track
        end tell
        """
    
    var error: NSDictionary?
    
    
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            let outputString = scriptObject.executeAndReturnError(&error)
            completion()
        }
    }
}


func getIsPlaying(completion: @escaping (NSAppleEventDescriptor)->()) {
    let myAppleScript = """
        using terms from application "Spotify"
            return (player state of application "Spotify" is playing)
        end using terms from
        """
    
    var error: NSDictionary?
    
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            let outputString = scriptObject.executeAndReturnError(&error)
            completion(outputString)
        }
    }
}
