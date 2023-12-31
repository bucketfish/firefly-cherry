//
//  PomodoroView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct PomodoroView: View {
    @AppStorage("showUpdates") private var showUpdates = true
    
    @AppStorage("enableSpotify") private var enableSpotify = true
    
    @AppStorage("pomodoroSymbol") var pomodoroSymbol = "🍅"
    
    let soundPlayer = CustomSoundPlayer.shared
    
    @StateObject var pomodoroClock = PomodoroClock()
    
    @EnvironmentObject var style: PomodoroStyle
    
    var body: some View {
        ZStack {
            // MARK: circular progress bar
            if (style.progressBarType == .circular) {
                PomodoroBackgroundCircularProgressView(percentage: $pomodoroClock.timePercentage)
            }
            
            VStack (spacing: 0){
                // MARK: pomodoro counter
                Text(String(repeating: pomodoroSymbol, count: pomodoroClock.currentPomodoroCount))
                    .customFont(.title)
                    .foregroundColor(Color("PomodoroText"))
                    .padding(.bottom, 10)
                
                // MARK: top progress bar
                if (style.progressBarType == .top) {
                    PomodoroBackgroundBarProgressView(percentage: $pomodoroClock.timePercentage)
                        .padding(.bottom, 10)
                }
                
                // MARK: state buttons
                HStack {
                    Button("pomodoro") {
                        pomodoroClock.changeTimerState(.pomodoro, autostart: false)
                    }
                    .buttonStyle(PomodoroStateButton(selected: pomodoroClock.currentPomodoroState == .pomodoro))
                    .padding([.leading, .top, .bottom], 5)
                    
                    Button("short break") {
                        pomodoroClock.changeTimerState(.short_break, autostart:false)
                    }
                    .buttonStyle(PomodoroStateButton(selected: pomodoroClock.currentPomodoroState == .short_break))
                    .padding(.vertical, 5)
                    
                    
                    Button("long break") {
                        pomodoroClock.changeTimerState(.long_break, autostart: false)
                    }
                    .buttonStyle(PomodoroStateButton(selected: pomodoroClock.currentPomodoroState == .long_break))
                    .padding([.trailing, .top, .bottom], 5)
                    
                    
                }
                .background(stringToColor(string: style.customColorString))
                .cornerRadius(style.cornerRadius)
                
                // MARK: main timer
                Text(pomodoroClock.displayTime)
                    .customFont(.largeTitle, customSize: 120)
                    .bold()
                    .padding(.bottom, style.timerBottomPadding)
                    .padding(.top, style.timerTopPadding)
                    .foregroundColor(Color("PomodoroText"))
                
                // MARK: spotify view
                if (enableSpotify == true) {
                    SpotifyNowPlayingView()
                        .padding(.top, -10)
                        .padding(.bottom, 10)
                }
                
                // MARK: middle progress bar
                if (style.progressBarType == .middle) {
                    PomodoroBackgroundBarProgressView(percentage: $pomodoroClock.timePercentage)
                        .padding(.bottom, 10)
                }
                
                // MARK: timer start button
                HStack {
                    Button(pomodoroClock.timerRunning ? "pause" : "start") {
                        switch pomodoroClock.timerRunning {
                        case true:
                            pomodoroClock.pauseTimer()
                        case false:
                            pomodoroClock.runTimer()
                        }
                    }
                    .buttonStyle(PomodoroStartButton())
                    .padding([.leading, .top, .bottom], 5)
                    
                    
                    Button {
                        pomodoroClock.resetTimer()
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
                .background(stringToColor(string: style.customColorString))
                .cornerRadius(style.cornerRadius)
                
                // MARK: bottom progress bar
                if (style.progressBarType == .bottom) {
                    PomodoroBackgroundBarProgressView(percentage: $pomodoroClock.timePercentage)
                        .padding(.top, 10)
                }
                
                // MARK: updates view
                if (showUpdates) { UpdateCheckView() }
            }
        }
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
