//
//  PomodoroBackgroundCircularProgressView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct PomodoroBackgroundCircularProgressView: View {
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30

    // in seconds
    @Binding var state: PomodoroState
    @Binding var current: Int
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color("AccentColor"), lineWidth: 8
                )
            
            Circle()
                .trim(from: 0, to: CGFloat((stateLength(state) * 60 - current)) / CGFloat(stateLength(state) * 60))
                .stroke(
                    Color("PomodoroText"),
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round
                        )
                )
                .rotationEffect(.degrees(-90))
            
            
        }
        .frame(width: 500, height: 500)
        
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
