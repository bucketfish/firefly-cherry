//
//  SpotifyHandler.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import Foundation
import SwiftUI

func testPlaySong() {

    let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
    let accessEnabled = AXIsProcessTrustedWithOptions(options)
          

    if !accessEnabled {
       print("Access Not Enabled")
    } else {
       print("Access Granted")
    }
    
    
    let myAppleScript = """
            tell application "Spotify"
                set c to current track
            end tell

            return name of c as text

    """
    var error: NSDictionary?
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            if let outputString = scriptObject.executeAndReturnError(&error).stringValue {
                print(outputString)
            } else if (error != nil) {
                print("error: ", error!)
            }
        }
    }
}



func getSongName(completion: @escaping (String)->()) {
    let myAppleScript = """
            tell application "Spotify"
                set c to current track
            end tell

            return name of c as text

    """
    var error: NSDictionary?
    var songName = ""
    
    DispatchQueue.global(qos: .background).async {
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            if let outputString = scriptObject.executeAndReturnError(&error).stringValue {
                songName = outputString
                completion(songName)
            } else if (error != nil) {
                print("error: ", error!)
            }
        }
    }
    
}
