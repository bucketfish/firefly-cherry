//
//  SpotifySettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct SpotifySettingsView: View {
    
    @AppStorage("enableSpotify") private var enableSpotify = true

    var body: some View {
        
        Form {
            Section {
                Toggle("enable spotify display", isOn: $enableSpotify)
            }
            //
            Button("test") {
                testPlaySong()
            }
        }
        
//
////
////
////            let source = """
////        tell application "Spotify"
////            play track "spotify:track:5C2yPF6xjPSvQbq28d1A4A"
////        end tell
////        """
////
////
////            let appleScript = NSAppleScript(source: source)
////
////            DispatchQueue.global(qos: .background).async {
////                        let success = appleScript?.compileAndReturnError(nil)
////                        assert(success != nil)
////                        print(success)
////                    }
//////
////            var errorDict: NSDictionary? = nil
////            let possibleResult = appleScript?.executeAndReturnError(&errorDict)
//
//
//        }
        
    }
}

struct SpotifySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifySettingsView()
    }
}
