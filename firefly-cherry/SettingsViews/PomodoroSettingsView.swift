//
//  PomodoroSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI
import AVFoundation

struct PomodoroSettingsView: View {
    // load up a bunch of defaults
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30
    
    @AppStorage("pomodoroIterations") private var pomodoroIterations = 4
    
    @AppStorage("timerSound") private var timerSound = TimerSounds.harp
    @AppStorage("useCustomTimerSound") private var useCustomTimerSound = false
    @AppStorage("customTimerSoundPath") private var customTimerSoundPath: URL?
    @AppStorage("timerVolume") private var timerVolume = 0.5
    
    // global sound player!
    @EnvironmentObject var soundPlayer: CustomSoundPlayer
    
    var body: some View {
        Form {
            Section (header: Text("timer duration (minutes)").bold()) {
                // set timer duration
                TextFieldWithStepper(title: "pomodoro", value: $pomodoroLength)
                TextFieldWithStepper(title: "short break", value: $shortbreakLength)
                TextFieldWithStepper(title: "long break", value: $longbreakLength)
                
                // reset to app defaults for timer duration
                Button("reset to default") {
                    pomodoroLength = 25
                    shortbreakLength = 5
                    longbreakLength = 30
                }
                
                TextFieldWithStepper(title: "iterations", value: $pomodoroIterations)
                    .onChange(of: pomodoroIterations) { newValue in
                        pomodoroIterations = max(newValue, 1)
                    }
                
            }
            
            Divider()
                .padding(.bottom)
            
            Section (header: Text("timer alarm").bold()) {
                Toggle("custom alarm sound", isOn: $useCustomTimerSound)
                    .onChange(of: useCustomTimerSound) { _ in
                        if (useCustomTimerSound) {
                            soundPlayer.setSound(customTimerSoundPath)
                        }
                        else {soundPlayer.setPremadeSound(timerSound.rawValue)}
                    }
                
                if (!useCustomTimerSound) {
                    // choose among default sounds
                    Picker(selection: $timerSound, label: Text("alarm sound")) {
                        Text("harp").tag(TimerSounds.harp)
                        Text("marimba").tag(TimerSounds.marimba)
                    }
                    .onChange(of: timerSound) { _ in
                        // when chosen, set it & test!
                        soundPlayer.setPremadeSound(timerSound.rawValue)
                        soundPlayer.play()
                    }
                }
                else {
                    // select alarm sound, show name, & test play
                    HStack {
                        PomodoroSettingsAlarmSoundFileChooser(filepath: $customTimerSoundPath)
                        Text(customTimerSoundPath?.lastPathComponent ?? "")
                        Button { soundPlayer.play() } label: { Image(systemName: "speaker.wave.2.fill") }
                    }
                    // when file is changed, set the soundplayer to it
                    .onChange(of: customTimerSoundPath) { _ in
                        soundPlayer.setSound(customTimerSoundPath)
                    }
                }
                
                // set volume!
                Slider(value: $timerVolume, onEditingChanged: { editing in
                    // when the volume isn't being edited, play the sound with new volume to test it
                    if (!editing) {
                        soundPlayer.setVolume(Float(timerVolume))
                        soundPlayer.play()
                    }
                }) { Text("volume") }
                 
            }
        }
    }
}

struct PomodoroSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroSettingsView()
    }
}
