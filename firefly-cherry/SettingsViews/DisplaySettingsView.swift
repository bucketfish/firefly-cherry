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
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""
    
    @AppStorage("timerTopPadding") private var timerTopPadding: Double = 10
    @AppStorage("timerBottomPadding") private var timerBottomPadding: Double = 0
    
    
    @AppStorage("imageInterpolation") private var imageInterpolation = false
    @AppStorage("imageType") private var imageType: ImageType = .premade
    @AppStorage("webImageLink") private var webImageLink: String = ""
    @AppStorage("localImageLink") private var localImageLink: URL?
    @AppStorage("backgroundImageIndex") private var backgroundImageIndex = 0
    
    @AppStorage("progressBarType") private var progressBarType: ProgressBarType = .circular
    @AppStorage("progressBarOpacity") private var progressBarOpacity = 0.5
    
    var backgroundImages = [
        "sample_background", "sunset"
    ]
    
    
    @State var showInterpolationPopover = false
    
    var body: some View {
        Form {
            Section (header: Text("general appearance").bold()) {
                Slider(value: $cornerRadius, in: 0...25, step: 1) {
                    Text("corner radius")
                }
                


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
                
                Slider(value: $progressBarOpacity, in: 0.1...1, step: 0.1) {
                    Text("opacity")
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
