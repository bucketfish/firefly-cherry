//
//  BackgroundImageView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct BackgroundImageView: View {
    @AppStorage("imageType") private var imageType: ImageType = .premade
    @AppStorage("imageInterpolation") private var imageInterpolation = false

    @AppStorage("webImageLink") private var webImageLink = ""
    @AppStorage("localImageLink") private var localImageLink: URL?
    @AppStorage("backgroundImageIndex") private var backgroundImageIndex = 0
    
    var backgroundImages = [
        "sample_background", "sunset"
    ]

    
    var body: some View {
        if (imageType == .web) {
            AsyncImage(url: URL(string: webImageLink)) { image in
                image
                    .interpolation(imageInterpolation ? .medium : .none)
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .ignoresSafeArea()
        }
        
        else if (imageType == .upload) {
            AsyncImage(url: localImageLink) { image in
                image
                    .interpolation(imageInterpolation ? .medium : .none)
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .ignoresSafeArea()
        }
        
        else {
            Image(backgroundImages[backgroundImageIndex])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }

}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
