//
//  PomodoroClock.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 9/9/23.
//

import Foundation
import SwiftUI

class PomodoroClock: ObservableObject {
    @Published var displayTime = "25:00"
    @Published var timePercentage = 0.0 // percentage for updating progress bar!
    @Published var timerRunning = false
    @Published var currentPomodoroState: PomodoroState = .pomodoro // current state
    @Published var currentPomodoroCount = 1
    
    @AppStorage("pomodoroIterations") var pomodoroIterations = 4
    
    @AppStorage("pomodoroLength") var pomodoroLength = 25
    @AppStorage("shortbreakLength") var shortbreakLength = 5
    @AppStorage("longbreakLength") var longbreakLength = 30
    
    @AppStorage("useDiscordRPC") private var useDiscordRPC = true
    @AppStorage("dRPCWhilePaused") private var dRPCWhilePaused = true
    
    var currentStateDuration = 25 * 60 // total duration for current state

    var currentStateEndTime = Date() // supposed end time, if clock is running
    var currentUpdatedTime = Date() // current "time"
    var pausedDurationLeft: TimeInterval = 0 // seconds left in timer, if paused
    
    let dcf = DateComponentsFormatter()
    
    let soundPlayer = CustomSoundPlayer.shared

    
    // MARK: init
    init () {
        self.dcf.allowedUnits = [.minute, .second]
        self.dcf.unitsStyle = .positional
        self.dcf.zeroFormattingBehavior = .pad
        
        self.pausedDurationLeft = TimeInterval(pomodoroLength * 60)
        
        updateDisplayTime()
    }
    
    
    // MARK: update display time
    // call this every second to update the dispaly time
    func updateDisplayTime(){
        // update self.displayTime
        if (self.timerRunning) {
            if let time = self.dcf.string(from: self.currentUpdatedTime, to: self.currentStateEndTime) {
                self.displayTime = time
            }
        }
        else if (self.pausedDurationLeft.isZero) {
            if let time = self.dcf.string(from: self.getStateLength(self.currentPomodoroState)) {
                self.displayTime = time
            }
        }
        
        else {
            if let time = self.dcf.string(from: self.pausedDurationLeft) {
                self.displayTime = time
            }
        }
        
        // update self.timePercentage
        if (self.timerRunning) {
            let timeLeft = self.currentUpdatedTime.distance(to: self.currentStateEndTime)
            let totalTime = self.getStateLength(self.currentPomodoroState)
            
            self.timePercentage = Double((totalTime - timeLeft) / totalTime)
        }
        else if (self.pausedDurationLeft.isZero) {
            self.timePercentage = 0
        }
        else {
            let timeLeft = self.pausedDurationLeft
            let totalTime = self.getStateLength(self.currentPomodoroState)
            self.timePercentage = Double( (totalTime - timeLeft) / totalTime)
        }
    }
    
    
    func increasePomoCount() {
        self.currentPomodoroCount += 1
    }
    
    
    // MARK: start running timer
    func runTimer() {
        // do not run it again if it is already running, for whatever reason
        if (self.timerRunning == true) {return}
        
        // setup timer, end time, current time
        self.timerRunning = true
        self.currentStateEndTime =
        pausedDurationLeft.isZero ?
        Date() + self.getStateLength(self.currentPomodoroState) :
        Date() + pausedDurationLeft
        self.currentUpdatedTime = Date()
        self.updateDisplayTime()
        
        // update discord rich presence
        if (self.useDiscordRPC) {
            connectRPC(pomoCount: self.currentPomodoroCount, pomoIterations: self.pomodoroIterations, currentState: self.currentPomodoroState, endingTime: self.currentStateEndTime)
        }
        
        // update time every second
        var curTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            // stop the timer if it's stopped. well.
            if (!self.timerRunning) {
                timer.invalidate()
            }
            
            else {
                // update current time to, well, the current time
                self.currentUpdatedTime = Date()
                self.updateDisplayTime()
                
                // stop the timer if time's up!!
                if self.currentUpdatedTime >= self.currentStateEndTime {
                    timer.invalidate()
                    self.soundPlayer.play()
                    if (self.currentPomodoroState == .pomodoro) { self.increasePomoCount() }
                    self.changeTimerState(self.getNextTimerState(self.currentPomodoroCount))
                }
            }
        }
        RunLoop.current.add(curTimer, forMode: .common)
        curTimer.tolerance = 0.1
    }
    
    
    // MARK: pause timer
    func pauseTimer() {
        self.timerRunning = false
        
        self.pausedDurationLeft = self.currentUpdatedTime.distance(to: self.currentStateEndTime)
        
        self.updateDisplayTime()
        
        // update discord rich presence
        if (self.useDiscordRPC) {
            connectRPC(pomoCount: self.currentPomodoroCount, pomoIterations: self.pomodoroIterations, currentState: self.currentPomodoroState, endingTime: self.currentStateEndTime, isPaused: true, showWhenPaused: self.dRPCWhilePaused)
        }
    }
    
    
    // MARK: reset timer
    func resetTimer() {
        changeTimerState(self.currentPomodoroState, autostart: false);
        updateDisplayTime()
    }
    
    
    // MARK: change timer state
    func changeTimerState(_ state: PomodoroState, autostart:Bool = true) {
        
        // stop the timer if it's running
        if (timerRunning) { pauseTimer() }
        
        // update states and stuff
        self.currentPomodoroState = state
        self.pausedDurationLeft = TimeInterval(0)
        self.updateDisplayTime()
        
        if (autostart) { self.runTimer() }
    }
    
    
    // MARK: get next timer state
    func getNextTimerState(_ pomoCount: Int) -> PomodoroState {
                
        if (self.currentPomodoroState == .pomodoro) {
            if ((pomoCount - 1) % self.pomodoroIterations == 0) { return .long_break }
            else { return .short_break }
        }
        else { return .pomodoro }
    }
    
    
    // MARK: get current state length
    func getStateLength(_ state: PomodoroState) -> TimeInterval {
        switch state {
        case .pomodoro: return TimeInterval(self.pomodoroLength * 60)
        case .short_break: return TimeInterval(self.shortbreakLength * 60)
        case .long_break: return TimeInterval(self.longbreakLength * 60)
        }
    }
}
