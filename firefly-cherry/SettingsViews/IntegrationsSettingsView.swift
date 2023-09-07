//
//  SpotifySettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct IntegrationsSettingsView: View {
    @AppStorage("useDiscordRPC") private var useDiscordRPC = true
    
    @AppStorage("enableSpotify") private var enableSpotify = true
    @AppStorage("showNextPrev") private var showNextPrev = true

    


    var body: some View {
        
        Form {
            Section (header: Text("discord").bold()) {
                Toggle("use discord rich presence", isOn: $useDiscordRPC)
            }
            
            Divider()
                .padding(.bottom)
            
            Section (header: Text("spotify").bold() ){
                Toggle("show spotify display", isOn: $enableSpotify)
                
                Toggle("show next/prev buttons", isOn: $showNextPrev)
                    .disabled(!enableSpotify)
            }
            
            
//            Button("test") {
//                getPlaySongAccess()
//            }
        }
        
    }
}

struct IntegrationsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        IntegrationsSettingsView()
    }
}
