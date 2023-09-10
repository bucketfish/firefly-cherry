//
//  PomodoroBackgroundCircularProgressView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct PomodoroBackgroundCircularProgressView: View {
    @EnvironmentObject var style: PomodoroStyle
    
    @Binding var percentage: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    stringToColor(string: style.customColorString), lineWidth: style.progressBarWidth
                )
            
            Circle()
                .trim(from: 0, to: CGFloat(percentage))
                .stroke(
                    Color("PomodoroText"),
                    style: StrokeStyle(
                        lineWidth: style.progressBarWidth,
                        lineCap: .round
                        )
                )
                .rotationEffect(.degrees(-90))
            
            
        }
        .frame(width: style.progressBarRadius, height: style.progressBarRadius)
        .opacity(style.progressBarOpacity)
        
    }

}
