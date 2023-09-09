//
//  PomodoroBackgroundBarProgressView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct PomodoroBackgroundBarProgressView: View {
    @AppStorage("customColor") private var customColorString: String = ""

    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30
    
    @AppStorage("progressBarWidth") private var progressBarWidth: Double = 8

    
    @AppStorage("progressBarOpacity") private var progressBarOpacity = 0.5
    
    


    // in seconds
//    @Binding var state: PomodoroState
//    @Binding var current: Int
    
    @Binding var percentage: Double
    
    var body: some View {
        
        let pomodoroStyle = PomodoroBarProgressStyle(
                    stroke: stringToColor(string: customColorString),
                    fill: Color("PomodoroText"),
                    height: progressBarWidth + 2
                )
        
        ProgressView(value: CGFloat(percentage))
            .progressViewStyle(pomodoroStyle)
            .frame(width: 500)
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



struct PomodoroBarProgressStyle<Stroke: ShapeStyle, Background: ShapeStyle>: ProgressViewStyle {
    var stroke: Stroke
    var fill: Background
    var cornerRadius: CGFloat = 25
    var height: CGFloat = 6
    var borderWidth: CGFloat = 1
    var animation: Animation = .easeInOut
    
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        VStack {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(stroke)
                    .cornerRadius(cornerRadius)
            }
            .frame(height: height + (borderWidth * 2))
            .cornerRadius(cornerRadius)
            .overlay(
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(fill)
                            .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                            .cornerRadius(cornerRadius)
                            .frame(height: height)
                        Spacer()
                    }
                    .padding(.horizontal, borderWidth)
                    .frame(height: height + (borderWidth * 2))
                    
                }
            )

        }
    }
}

//struct PomodoroBackgroundBarProgressView_Previews: PreviewProvider {
//    static var previews: some View {
////        PomodoroBackgroundBarProgressView(state: .constant(.pomodoro), current: .constant(12*60))
//    }
//}
