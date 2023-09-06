//
//  PomodoroView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

enum PomodoroState {
    case pomodoro, short_break, long_break
}

struct PomodoroView: View {
    
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30

    
    @State var duration = 25 * 60
    @State var current_state: PomodoroState = .pomodoro
    @State var completed_pomodoros = 0
    
    @State var timerRunning = false
    
    
    var body: some View {
  
            VStack (spacing: 0){
                
                    HStack {
                        Button("pomodoro") {
                            changeTimerState(.pomodoro, autostart: false)
                        }
                        .buttonStyle(PomodoroStateButton(selected: current_state == .pomodoro))
                        .padding([.leading, .top, .bottom], 5)
                        
                        Button("short break") {
                            
                            changeTimerState(.short_break, autostart: false)
                            
                            
                        }
                        .buttonStyle(PomodoroStateButton(selected: current_state == .short_break))
                        .padding(.vertical, 5)

                        
                        Button("long break") {
                            
                            changeTimerState(.long_break, autostart: false)
                            
                            
                        }
                        .buttonStyle(PomodoroStateButton(selected: current_state == .long_break))
                        .padding([.trailing, .top, .bottom], 5)

                        
                    }
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    
                    
            
                
                Text(formatTimer(duration))
                    .font(.custom("Avenir", size: 120, relativeTo: .largeTitle))
                    .bold()
                
                HStack {
                    Button(timerRunning ? "pause" : "start") {
                        switch timerRunning {
                        case true:
                            pauseTimer()
                        case false:
                            runTimer()
                        }
                        
                    }
                    .buttonStyle(PomodoroStartButton())
                    .padding([.leading, .top, .bottom], 5)
                    
                    
                    Button {
                        resetTimer()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)

                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 5)
                    
                    Button {
                        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)

                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 5)
                    .padding([.trailing, .top, .bottom], 5)
                }
                .background(Color("AccentColor"))
                .cornerRadius(10)
                
            }
    }
    
    func formatTimer(_ duration:Int) -> String {
        let minutes = Int(duration / 60);
        let seconds = Int(duration % 60);
        
        return (minutes < 10 ? "0" + String(minutes) : String(minutes)) + ":" + (seconds < 10 ? "0" + String(seconds) : String(seconds))
    }
    
    func runTimer() {
        if (timerRunning == true) {
            return
        }
        
        timerRunning = true
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if (!timerRunning) {
                timer.invalidate()
            }
            else {
                duration -= 1
            }
            
            
  
            if (duration <= 0) {
                timer.invalidate()
                nextTimerState()
            }
            
            
            
        }
    }
    
    func pauseTimer() {
        timerRunning = false
    }
    
    func nextTimerState() {
        if (current_state == .pomodoro) {
            completed_pomodoros += 1
        
            if (completed_pomodoros == 4) {
                changeTimerState(.long_break)
            }
            else {
                changeTimerState(.short_break)
            }
        }
        else {
            changeTimerState(.pomodoro)
        }
    }
    
    func resetTimer() {
        changeTimerState(current_state, autostart: false);
    }
    
    func changeTimerState(_ state: PomodoroState, autostart:Bool = true) {
        
        pauseTimer()
        
        
        switch state {
        case .pomodoro:
            duration = pomodoroLength * 60
        case .short_break:
            duration = shortbreakLength * 60
        case .long_break:
            duration = longbreakLength * 60
        }
        
        current_state = state
        
        
        if (autostart) {
            runTimer()
        }
        
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
