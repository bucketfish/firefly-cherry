//
//  PomodoroStartButton.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation
import SwiftUI


struct PomodoroStartButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
//            .background(.white)
            .cornerRadius(10)
            .font(.title)
            .contentShape(Rectangle())
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.white, lineWidth: 2)
            )
            .foregroundColor(.white)
//            .bold()
            
    }
}
