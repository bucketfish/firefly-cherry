//
//  PomodoroStyle.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 9/9/23.
//

import Foundation
import SwiftUI

class PomodoroStyle: ObservableObject {
    @AppStorage("useCustomFont") var useCustomFont = false
    @AppStorage("customFontName") var customFontName = ""
    
    @AppStorage("cornerRadius") var cornerRadius: Double = 10
    @AppStorage("customColor") var customColorString: String = ""
    
    @AppStorage("timerTopPadding") var timerTopPadding: Double = 10
    @AppStorage("timerBottomPadding") var timerBottomPadding: Double = 10
        
    @AppStorage("progressBarType") var progressBarType: ProgressBarType = .circular
    
    
    @AppStorage("progressBarOpacity") var progressBarOpacity = 0.5
    
    @AppStorage("progressBarWidth") var progressBarWidth: Double = 8
    @AppStorage("progressBarRadius") var progressBarRadius: Double = 500


//    var font: String = ""
    
    init() {
        
    }
}
