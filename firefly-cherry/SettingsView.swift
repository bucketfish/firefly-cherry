//
//  SettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

enum ImageType: String, Equatable, CaseIterable {
    case premade, web, upload
    var id: Self { self }
}



enum ColorScheme: String, Equatable, CaseIterable {
    case light, dark, system
    var id: Self { self }
}


struct TextFieldWithStepper: View {
    @State var title: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            TextField(title, value: $value, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)
                .fixedSize(horizontal: true, vertical: false)

            Stepper(title, value: $value)
                .labelsHidden()
        }
    }
}


struct GeneralSettingsView: View {
    
    var body: some View {
        Button("disconnect from discord rich presence") {
            
        }
    }
    
}
struct PomodoroSettingsView: View {
//    @AppStorage("showPreview") private var showPreview = true
//    @AppStorage("fontSize") private var fontSize = 12.0
    
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30

    @State var timerSoundIndex = 0
    
    var timerSounds = [
    "apple pie", "idk bro", "lemonade", "yasss"
    ]

    var body: some View {
        Form {
            Section (header: Text("timer duration (minutes)").bold()) {
                TextFieldWithStepper(title: "pomodoro", value: $pomodoroLength)
                TextFieldWithStepper(title: "short break", value: $shortbreakLength)
                TextFieldWithStepper(title: "long break", value: $longbreakLength)

                Button("reset to default") {
                    pomodoroLength = 25
                    shortbreakLength = 5
                    longbreakLength = 30
                }

            }
            
            Divider()
                .padding(.bottom)
            
            Section (header: Text("timer sound").bold()) {
                Picker(selection: $timerSoundIndex, label: Text("timer sound")) {
                    ForEach(0 ..< timerSounds.count) { count in
                        Text(self.timerSounds[count])
                    }
                }
            }

        }
        
        
    }
}

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


struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, pomodoro, display
    }
    var body: some View {
        TabView {
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

        }
        .padding(20)
        
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
