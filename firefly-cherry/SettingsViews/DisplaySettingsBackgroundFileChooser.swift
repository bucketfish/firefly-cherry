//
//  DisplaySettingsBackgroundFileChooser.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct DisplaySettingsBackgroundFileChooser: View {
    @Binding var filepath: URL?
    
    var body: some View {
        Button("choose local image") {
            let dialog = NSOpenPanel();

            dialog.title = "choose an image | firefly-cherry";
            dialog.showsResizeIndicator = true;
            dialog.showsHiddenFiles = false;
            dialog.allowsMultipleSelection = false;
            dialog.canChooseDirectories = false;
            dialog.allowedContentTypes = [.png, .jpeg];

            let modalResponse = dialog.runModal()
            if modalResponse == .OK {
                filepath = dialog.url
            }
            else {
                
            }
        }
        
    }
}

