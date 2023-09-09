//
//  GeneralSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct GeneralSettingsView: View {
    @Environment(\.openURL) var openURL
    
    @AppStorage("showUpdates") private var showUpdates = true
    
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
                    if let url = URL(string:updateUrl) {
                        openURL (url)
                    }
                }
                .disabled(!needsUpdate)
                
                Toggle("tell me when there's an update!", isOn: $showUpdates)
                
            }
        }
    }
    
}
struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
