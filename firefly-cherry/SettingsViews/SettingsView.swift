//
//  SettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI




struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, pomodoro, display, spotify
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                
                .tabItem {
                    Label("general", systemImage: "gearshape")
                }
                .tag(Tabs.general)
            PomodoroSettingsView()
                
                .tabItem {
                    Label("pomodoro", systemImage: "clock")
                }
                .tag(Tabs.pomodoro)
            DisplaySettingsView()
                .tabItem{
                    Label("display", systemImage: "display")
                }
                .tag(Tabs.display)
            
            SpotifySettingsView()
                .tabItem{
                    Label("spotify", systemImage: "music.note")
                }
                .tag(Tabs.spotify)

        }
    
        .padding(20)
        .frame(minWidth: 400)
        
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
