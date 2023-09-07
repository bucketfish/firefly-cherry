//
//  PomodoroStartButton.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation
import SwiftUI


struct PomodoroStartButton: ButtonStyle {
    @AppStorage("cornerRadius") private var cornerRadius: Double = 10
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""


    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
//            .background(.white)
            .cornerRadius(cornerRadius - 5)
            .font(.custom(useCustomFont ? customFontName : "", size: 22, relativeTo: .title))

            .contentShape(Rectangle())
            .overlay (
                RoundedRectangle(cornerRadius: cornerRadius - 5)
                    .strokeBorder(Color("PomodoroText"), lineWidth: 2)
            )
            .foregroundColor(Color("PomodoroText"))
//            .bold()
            
    }
}
