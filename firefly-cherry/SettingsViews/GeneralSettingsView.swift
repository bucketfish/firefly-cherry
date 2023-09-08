//
//  GeneralSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI
import Subsonic

struct GeneralSettingsView: View {
    
    var body: some View {
        Form {
            Button("test") {
                NSApplication.shared.orderFrontCharacterPalette(nil) 
            }
            
        }
    }
    
}
struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
