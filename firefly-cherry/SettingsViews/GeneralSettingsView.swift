//
//  GeneralSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct GeneralSettingsView: View {
    @AppStorage("useDiscordRPC") private var useDiscordRPC = true
    
    var body: some View {
        Form {
            Section (header: Text("discord rich presence").bold()) {
                Toggle("use discord rich presence", isOn: $useDiscordRPC)
            }
            
        }
    }
    
}
struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
