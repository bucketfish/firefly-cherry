//
//  GeneralSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI
import Subsonic

struct GeneralSettingsView: View {
    @Environment(\.openURL) var openURL
    
    @State var needsUpdate = false
    @State var updateUrl = ""
    
    var body: some View {
        Form {
            Section(header: Text("updates").bold()) {
                
                Text("current version: v" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))
                
                Text(needsUpdate ? "new update available!" : "firefly-cherry is up to date!")
                    .onAppear {
                        isOnLatestVer { isOn, newUrl in
                            needsUpdate = !isOn
                            updateUrl = newUrl
                        }
                    }
                
                Button("download latest update") {
                    openURL(URL(string: updateUrl)!)
                }
                .disabled(!needsUpdate)
            }
        }
    }
    
}
struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
