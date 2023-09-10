//
//  BackgroundImageView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct BackgroundImageView: View {
    @EnvironmentObject var backgroundStyle: BackgroundStyle

    var body: some View {
        if (backgroundStyle.imageType == .web) {
            AsyncImage(url: URL(string: backgroundStyle.webImageLink)) { image in
                image
                    .interpolation(backgroundStyle.imageInterpolation ? .medium : .none)
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        }
        
        else if (backgroundStyle.imageType == .local) {
            AsyncImage(url: backgroundStyle.localImageLink) { image in
                image
                    .interpolation(backgroundStyle.imageInterpolation ? .medium : .none)
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        }
        
        else {
            Image(backgroundStyle.premadeBackgroundImage.rawValue)
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
