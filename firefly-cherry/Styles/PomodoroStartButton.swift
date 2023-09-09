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
    
    @EnvironmentObject var style: PomodoroStyle


    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
//            .background(.white)
            .cornerRadius(cornerRadius - 5)
            .customFont(.title2)
            .contentShape(Rectangle())
            .overlay (
                RoundedRectangle(cornerRadius: cornerRadius - 5)
                    .strokeBorder(Color("PomodoroText"), lineWidth: 2)
            )
            .foregroundColor(Color("PomodoroText"))
            
    }
}
