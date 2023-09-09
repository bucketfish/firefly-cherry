//
//  CustomText.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 9/9/23.
//

import SwiftUI

struct CustomFontModifier: ViewModifier {
    @State var fontSize: Font.TextStyle = .body
    @State var customSize: CGFloat?

    @EnvironmentObject var style: PomodoroStyle
    func body(content: Content) -> some View {
        content
            .font(.custom(style.useCustomFont ? style.customFontName : "",
                          size: customSize ??
                            (fontSize == .largeTitle ? 24 :
                            fontSize == .title ? 28 :
                            fontSize == .title2 ? 22 :
                            fontSize == .title3 ? 20 :
                            17.0),
                          relativeTo: fontSize))
    }
}

extension View {
    func customFont(_ fontSize: Font.TextStyle, customSize: CGFloat? = nil) -> some View {
        modifier(CustomFontModifier(fontSize: fontSize, customSize: customSize))
    }
}

