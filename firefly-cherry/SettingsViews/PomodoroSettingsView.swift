//
//  PomodoroSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI
import Subsonic

struct PomodoroSettingsView: View {
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30

    @AppStorage("timerSound") private var timerSound = TimerSounds.harp
    @AppStorage("timerVolume") private var timerVolume = 0.5


    var body: some View {
        Form {
            Section (header: Text("timer duration (minutes)").bold()) {
                TextFieldWithStepper(title: "pomodoro", value: $pomodoroLength)
                TextFieldWithStepper(title: "short break", value: $shortbreakLength)
                TextFieldWithStepper(title: "long break", value: $longbreakLength)

                Button("reset to default") {
                    pomodoroLength = 25
                    shortbreakLength = 5
                    longbreakLength = 30
                }

            }
            
            Divider()
                .padding(.bottom)
            
            Section (header: Text("timer alarm").bold()) {
                Picker(selection: $timerSound, label: Text("alarm sound")) {
                    Text("harp").tag(TimerSounds.harp)
                    Text("marimba").tag(TimerSounds.marimba)
                }
                .onChange(of: timerSound) { _ in
                    stopAllManagedSounds()
                    play(sound: timerSound.rawValue + ".mp3", volume: timerVolume)
                }
                
                Slider(value: $timerVolume, onEditingChanged: { editing in
                    if (!editing) {
                        stopAllManagedSounds()
                        play(sound: timerSound.rawValue + ".mp3", volume: timerVolume)
                    }
                }) {
                    Text("volume")
                }
//                .onChange(of: timerVolume) { _ in
//                    play(sound: timerSound.rawValue + ".mp3", volume: timerVolume)
//
//                }
                
                
            }

        }
        
        
    }
}

struct PomodoroSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroSettingsView()
    }
}
