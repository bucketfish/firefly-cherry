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
    @StateObject var soundPlayer = CustomSoundPlayer()

//    @AppStorage("customAccentColor") private var customAccentColor = Color("PomodoroText")
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
                .environmentObject(soundPlayer)

                
            
        }
        
        .windowStyle(.hiddenTitleBar)
        
        #if os(macOS)
        Settings {
            SettingsView()
                .environmentObject(soundPlayer)
        }
        
        #endif
        
        
    }
}
