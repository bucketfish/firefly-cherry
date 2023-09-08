//
//  PomodoroView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI
import Subsonic

struct PomodoroView: View {
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""

    
    @AppStorage("enableSpotify") private var enableSpotify = true

    @AppStorage("cornerRadius") private var cornerRadius: Double = 10
    @AppStorage("customColor") private var customColorString: String = ""
    
    @AppStorage("timerTopPadding") private var timerTopPadding: Double = 10
    @AppStorage("timerBottomPadding") private var timerBottomPadding: Double = 10
    
    @AppStorage("pomodoroSymbol") private var pomodoroSymbol = "🍅"


    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30
    
    @AppStorage("useDiscordRPC") private var useDiscordRPC = true
    
    @AppStorage("timerSound") private var timerSound: TimerSounds = .harp
    @AppStorage("timerVolume") private var timerVolume = 0.5
    
    @AppStorage("progressBarType") private var progressBarType: ProgressBarType = .circular

    
    @State var duration = 25 * 60
    @State var current_state: PomodoroState = .pomodoro
    @State var pomodoro_count = 1
    
    @State var timerRunning = false
    
    
    var body: some View {
        ZStack {
            if (progressBarType == .circular) {
                PomodoroBackgroundCircularProgressView(state: $current_state, current: $duration)
            }

            VStack (spacing: 0){
                
                Text("\(String(repeating: pomodoroSymbol, count: pomodoro_count))")
                    .font(.custom(useCustomFont ? customFontName : "", size: 24, relativeTo: .largeTitle))
                    .foregroundColor(Color("PomodoroText"))
                    .padding(.bottom, 10)
                
                if (progressBarType == .top) {
                    PomodoroBackgroundBarProgressView(state: $current_state, current: $duration)
                        .padding(.bottom, 10)
                }
                
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
                    .background(stringToColor(string: customColorString))
                    .cornerRadius(cornerRadius)
                    
                    
            
                
                Text(formatTimer(duration))
                    .font(.custom(useCustomFont ? customFontName : "", size: 120, relativeTo: .largeTitle))
                    .bold()
                    .padding(.bottom, timerBottomPadding)
                    .padding(.top, timerTopPadding)
                    .foregroundColor(Color("PomodoroText"))
                
                if (enableSpotify == true) {
                    SpotifyNowPlayingView()
                        .padding(.top, -10)
                        .padding(.bottom, 10)
                }
                
                if (progressBarType == .middle) {
                    PomodoroBackgroundBarProgressView(state: $current_state, current: $duration)
                        .padding(.bottom, 10)
                }
                
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
                            .foregroundColor(Color("PomodoroText"))

                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 5)
                    
                    Button {
                        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color("PomodoroText"))

                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 5)
                    .padding([.trailing, .top, .bottom], 5)
                }
                .background(stringToColor(string: customColorString))
                .cornerRadius(cornerRadius)
                
                if (progressBarType == .bottom) {
                    PomodoroBackgroundBarProgressView(state: $current_state, current: $duration)
                        .padding(.top, 10)
                }
                
            }
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
        
        if (useDiscordRPC) {setupRPC(pomocount: pomodoro_count, state: current_state, countdownTime: duration)}
        
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
        
        if (useDiscordRPC) { setupRPC(pomocount: pomodoro_count, state: current_state, paused: true) }
    }
    // MARK: time's up
    func nextTimerState() {
        play(sound: timerSound.rawValue + ".mp3", volume: timerVolume)
        
        if (current_state == .pomodoro) {
            pomodoro_count += 1
        
            if (pomodoro_count > 4) {
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
        
        if (timerRunning) {
            pauseTimer()
        }
        
        current_state = state
        
        duration = stateLength(state) * 60
        
        
        if (autostart) {
            runTimer()
        }
        
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

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
