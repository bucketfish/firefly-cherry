//
//  UpdateCheckView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 8/9/23.
//

import SwiftUI

struct UpdateCheckView: View {
    @Environment(\.openURL) var openURL
    @State var needsUpdate = false
    
    @State var updateUrl = ""
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""
    
    
    var body: some View {
        
        HStack {
            
            Button {
                openURL(URL(string: updateUrl)!)

//                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            } label: {
                HStack {
                    if (needsUpdate) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title2)
                            .foregroundColor(Color("PomodoroText"))
                            .padding(.vertical)
                        
                        Text("new update available!")
                            .padding(.vertical)
                            .font(.custom(useCustomFont ? customFontName : "", size: 18, relativeTo: .title2))
                            .foregroundColor(Color("PomodoroText"))
                        
                    }
                }
            }
            .buttonStyle(.plain)
            .opacity(0.8)
        
        }.onAppear {
            isOnLatestVer { isOn, newUrl in
                needsUpdate = !isOn
                updateUrl = newUrl
            }
        }

        
    }
}

struct UpdateCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateCheckView()
    }
}
