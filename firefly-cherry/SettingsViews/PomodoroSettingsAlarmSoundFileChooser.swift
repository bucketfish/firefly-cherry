//
//  PomodoroSettingsAlarmSoundFileChooser.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 8/9/23.
//

import SwiftUI

struct PomodoroSettingsAlarmSoundFileChooser: View {
    @Binding var filepath: URL?
    
    var body: some View {
        Button("choose local audio") {
            let dialog = NSOpenPanel();

            dialog.title = "choose a sound | firefly-cherry";
            dialog.showsResizeIndicator = true;
            dialog.showsHiddenFiles = false;
            dialog.allowsMultipleSelection = false;
            dialog.canChooseDirectories = false;
            dialog.allowedContentTypes = [.mp3, .audio];

            let modalResponse = dialog.runModal()
            if modalResponse == .OK {
                filepath = dialog.url
            }
            else {
                
            }
        }
        
    }
}

