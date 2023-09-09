//
//  DisplaySettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

func colorToString(color: Color)-> String {
    let uiColor = NSColor(color)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return "\(red),\(green),\(blue),\(alpha)"
}

func stringToColor(string: String) -> Color {
    let rgbArray = string.components(separatedBy: ",")
    if let red = Double (rgbArray[0]), let green = Double (rgbArray[1]), let blue = Double(rgbArray[2]), let alpha = Double (rgbArray[3]) {
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    return Color("AccentColor")
}

struct DisplaySettingsView: View {
    
    @AppStorage("cornerRadius") private var cornerRadius: Double = 10
    
    @AppStorage("customColor") private var customColorString: String = ""
    @State var customColor: Color = Color("AccentColor")
    @AppStorage("colorScheme") private var colorScheme: ColorScheme = .system
    
    @AppStorage("pomodoroSymbol") private var pomodoroSymbol = "🍅"
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""
    
    @AppStorage("timerTopPadding") private var timerTopPadding: Double = 10
    @AppStorage("timerBottomPadding") private var timerBottomPadding: Double = 0
    
    @AppStorage("imageInterpolation") private var imageInterpolation = false
    @AppStorage("imageType") private var imageType: ImageType = .premade
    @AppStorage("webImageLink") private var webImageLink: String = ""
    @AppStorage("localImageLink") private var localImageLink: URL?
    @AppStorage("premadeBackgroundImage") private var premadeBackgroundImage: BackgroundImages = .sunset
    
    @AppStorage("progressBarType") private var progressBarType: ProgressBarType = .circular
    @AppStorage("progressBarOpacity") private var progressBarOpacity = 0.5
    @AppStorage("progressBarRadius") private var progressBarRadius: Double = 500
    @AppStorage("progressBarWidth") private var progressBarWidth: Double = 8
    
    var backgroundImages = [
        "sample_background", "sunset"
    ]
    
    
    @State var showInterpolationPopover = false
    
    var body: some View {
        Form {
            Section (header: Text("font & color").bold()) {
                Picker(selection: $colorScheme, label: Text("text color")) {
                    ForEach(ColorScheme.allCases, id: \.id) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                
                HStack {
                    ColorPicker("boxes color", selection: $customColor)
                        .onChange(of: customColor) { _ in
                            customColorString = colorToString(color: customColor)
                        }
                        .onAppear {
                            customColor = stringToColor(string: customColorString)
                        }
                    
                    Button("reset color") {
                        customColorString = "\(1.000),\(0.714),\(0.757),\(0.67)"
                        customColor = stringToColor(string: customColorString)
                    }
                }
                

                
                Toggle("use custom font", isOn: $useCustomFont)
                
                TextField("custom font name", text: $customFontName)
                    .textFieldStyle(.roundedBorder)
                    .disabled(!useCustomFont)
            }
            
            Divider()
                .padding(.bottom)
            
            Section (header: Text("spacing & layout").bold() ) {

                
                Slider(value: $cornerRadius, in: 0...25, step: 1) {
                    Text("corner radius")
                }
                Slider(value: $timerTopPadding, in: -50...50) {
                    Text("timer top gap")
                }
                Slider(value: $timerBottomPadding, in: -50...50) {
                    Text("timer bottom gap")
                }
            }
            
            
            Divider()
                .padding(.bottom)
            
            
            Section (header: Text("background image").bold()) {
                Picker(selection: $imageType, label: Text("image source")) {
                    
                    ForEach(ImageType.allCases, id: \.id) { type in
                        Text(type.rawValue).tag(type)
                    }
                    
                }
                .pickerStyle(.segmented)
                
                if (imageType == .premade) {
                    Picker(selection: $premadeBackgroundImage, label: Text("choose image")) {
                        ForEach(BackgroundImages.allCases, id: \.id) { image in
                            Text(image.rawValue)
                        }
                    }
                }
                else if (imageType == .web) {
                    TextField("web image link", text: $webImageLink)
                        .textFieldStyle(.roundedBorder)
                }
                else {
                    DisplaySettingsBackgroundFileChooser(filepath: $localImageLink)
                }
                
                HStack (alignment: .bottom) {
                    Toggle("interpolate image", isOn: $imageInterpolation)
                    
                    Button {
                        showInterpolationPopover.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .popover(isPresented: $showInterpolationPopover) {
                                Text("turn this off if you're using pixel art!")
                                    .padding()
                            }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 2)
            }
            
            Divider()
                .padding(.bottom)
            
            Section(header: Text("progress bar").bold()) {
                Picker(selection: $progressBarType, label: Text("type")) {
                    ForEach(ProgressBarType.allCases, id: \.id) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                
                Slider(value: $progressBarRadius, in:200...1000) {
                    Text("circle radius")
                }
                .disabled(!(progressBarType == .circular))
                
                Slider(value: $progressBarWidth, in: 5...100) {
                    Text("width")
                }
                .disabled(progressBarType == .none)
                
                Slider(value: $progressBarOpacity, in: 0.1...1) {
                    Text("opacity")
                }
                .disabled(progressBarType == .none)
            }
            
            Divider()
                .padding(.bottom)
            
            Section(header: Text("misc settings").bold()) {
                HStack {
                    TextField("pomodoro symbol", text: $pomodoroSymbol)
                        .frame(width: 200)
                        .textFieldStyle(.roundedBorder)

                    Button("open character palette") {
                        NSApplication.shared.orderFrontCharacterPalette(nil)
                    }
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
