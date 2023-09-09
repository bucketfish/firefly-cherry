//
//  PomodoroBackgroundCircularProgressView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct PomodoroBackgroundCircularProgressView: View {
    @AppStorage("customColor") private var customColorString: String = ""

    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30
    
    @AppStorage("progressBarOpacity") private var progressBarOpacity = 0.5
    
    @AppStorage("progressBarWidth") private var progressBarWidth: Double = 8
    @AppStorage("progressBarRadius") private var progressBarRadius: Double = 500

    // in seconds
    @Binding var state: PomodoroState
    @Binding var current: Int
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    stringToColor(string: customColorString), lineWidth: progressBarWidth
                )
            
            Circle()
                .trim(from: 0, to: CGFloat((stateLength(state) * 60 - current)) / CGFloat(stateLength(state) * 60))
                .stroke(
                    Color("PomodoroText"),
                    style: StrokeStyle(
                        lineWidth: progressBarWidth,
                        lineCap: .round
                        )
                )
                .rotationEffect(.degrees(-90))
            
            
        }
        .frame(width: progressBarRadius, height: progressBarRadius)
        .opacity(progressBarOpacity)
        
    }
    
    func stateLength(_ state: PomodoroState) -> Int {
        switch state {
        case .pomodoro:
            return pomodoroLength
        case .short_break:
            return shortbreakLength
        case .long_break:
            return longbreakLength
        }
    }
}
//
//struct PomodoroBackgroundCircularProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        PomodoroBackgroundCircularProgressView(current: .constant(12 * 60))
//    }
//}
