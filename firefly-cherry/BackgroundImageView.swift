//
//  BackgroundImageView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct BackgroundImageView: View {
    @AppStorage("useWebImage") private var useWebImage = false
    @AppStorage("webImageLink") private var webImageLink = ""
    @AppStorage("backgroundImageIndex") private var backgroundImageIndex = 0
    
    @State var testoggle = true
    var backgroundImages = [
        "sample_background", "sunset"
    ]

    
    var body: some View {
        if (useWebImage) {
            AsyncImage(url: URL(string: webImageLink)) { image in
                image.resizable()
                
            } placeholder: {
                ProgressView()
            }
            .onChange(of: webImageLink) {newLink in
                testoggle.toggle()
            }

            
        }
        else {
            Image(backgroundImages[backgroundImageIndex])
                .resizable()
                .scaledToFill()
        }
    }

}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
