//
//  UpdateCheckView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 8/9/23.
//

import SwiftUI

struct UpdateCheckView: View {
    @State var needsUpdate = false
    
    @State var inSettings = false
    
    @State var updateUrl = ""
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""
    
    
    var body: some View {
        
        Text(needsUpdate ? "update required!" : "up to date :)")
            .padding(.trailing, 10)
            .padding(.bottom, 10)
            .font(inSettings ? .body : .custom(useCustomFont ? customFontName : "", size: 24, relativeTo: .largeTitle))
            .foregroundColor(inSettings ?  Color.primary : Color("PomodoroText"))
            .onAppear {
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
