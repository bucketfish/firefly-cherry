//
//  BackgroundStyle.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 9/9/23.
//

import Foundation
import SwiftUI

class BackgroundStyle: ObservableObject {
    @AppStorage("imageInterpolation") var imageInterpolation = false
    @AppStorage("imageType") var imageType: ImageType = .premade
    @AppStorage("webImageLink") var webImageLink: String = ""
    @AppStorage("localImageLink") var localImageLink: URL?
    @AppStorage("premadeBackgroundImage") var premadeBackgroundImage: BackgroundImages = .sunset

    
    init() {}

}
