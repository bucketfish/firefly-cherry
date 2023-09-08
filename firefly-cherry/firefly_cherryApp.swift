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
            
        }
//        .commands {
//            CommandGroup(replacing: .appInfo) {
//                Button("About firefly-cherry") {
//                    NSApplication.shared.orderFrontStandardAboutPanel(
//                        options: [
//                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
//                                string: "firefly-cherry is a cute & customisable pomodoro app made by bucketfish :)"
////                                attributes: [
////                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
////                                        ofSize: NSFont.smallSystemFontSize)
////                                ]
//                            ),
//                            NSApplication.AboutPanelOptionKey(
//                                rawValue: "Copyright"
//                            ): "© 2023 bucketfish"
//                        ]
//                    )
//                }
//            }
//        }
        .windowStyle(.hiddenTitleBar)
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        
        #endif
        
        
    }
}
