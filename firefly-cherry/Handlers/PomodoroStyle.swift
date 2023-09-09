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

//    var font: String = ""
    
    init() {
        
    }
}
