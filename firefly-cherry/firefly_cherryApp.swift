//
//  firefly_cherryApp.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

@main
struct firefly_cherryApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("colorScheme") private var colorScheme: ColorScheme = .system
    
    @AppStorage("timerSound") private var timerSound = TimerSounds.harp
    @AppStorage("useCustomTimerSound") private var useCustomTimerSound = false
    @AppStorage("customTimerSoundPath") private var customTimerSoundPath: URL?
    @AppStorage("timerVolume") private var timerVolume = 0.5

    let soundPlayer = CustomSoundPlayer.shared

    @Environment(\.colorScheme) private var defaultScheme

    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(Color("PomodoroText"))
                .preferredColorScheme(colorScheme == ColorScheme.system ? defaultScheme : colorScheme == ColorScheme.dark ? .dark : .light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onDisappear {
                    NSApplication.shared.terminate(self)
                }
                .onAppear {
                    // set up sound system first
                    if (useCustomTimerSound) { soundPlayer.setSound(customTimerSoundPath) }
                    else { soundPlayer.setPremadeSound(timerSound.rawValue) }
                    soundPlayer.setVolume(Float(timerVolume))
                }

                
            
        }
        
        .windowStyle(.hiddenTitleBar)
        
        #if os(macOS)
        Settings {
            SettingsView()
//                .environmentObject(soundPlayer)
        }
        
        #endif
        
        
    }
}
