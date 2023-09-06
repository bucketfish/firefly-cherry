//
//  DisplaySettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct DisplaySettingsView: View {
    @AppStorage("colorScheme") private var colorScheme: ColorScheme = .system
    @AppStorage("imageType") private var imageType: ImageType = .premade
    @AppStorage("webImageLink") private var webImageLink: String = ""
    @AppStorage("backgroundImageIndex") private var backgroundImageIndex = 0
    
    var backgroundImages = [
        "sample_background", "sunset"
    ]
    
    var body: some View {
        Form {
            Section (header: Text("colors").bold()) {
                Picker(selection: $colorScheme, label: Text("color scheme")) {
                    Text("light").tag(ColorScheme.light)
                    Text("dark").tag(ColorScheme.dark)
                    Text("system").tag(ColorScheme.system)
                }
                .pickerStyle(.segmented)
                
            }
            
            
            Divider()
                .padding(.bottom)
            
            
            Section (header: Text("background image").bold()) {
                Picker(selection: $imageType, label: Text("image source")) {
                    Text("default").tag(ImageType.premade)
                    Text("web image").tag(ImageType.web)
                    Text("custom").tag(ImageType.upload)
                }
                .pickerStyle(.segmented)
                
                if (imageType == .premade) {
                    Picker(selection: $backgroundImageIndex, label: Text("choose image")) {
                        ForEach(0..<backgroundImages.count) {count in
                            HStack {
                                Text(self.backgroundImages[count])
                            }
                        }
                    }
                }
                else if (imageType == .web) {
                    TextField("web image link", text: $webImageLink)
                        .textFieldStyle(.roundedBorder)
                }
                else {
                    Text("coming soon!")
                    
                    
                }
            }
            
        }
    
    }
        
}

struct DisplaySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DisplaySettingsView()
    }
}
