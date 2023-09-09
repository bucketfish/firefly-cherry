//
//  PomodoroSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI
import Subsonic
import AVFoundation

struct PomodoroSettingsView: View {
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30
    
    @AppStorage("timerSound") private var timerSound = TimerSounds.harp
    @AppStorage("useCustomTimerSound") private var useCustomTimerSound = false
    @AppStorage("customTimerSoundPath") private var customTimerSoundPath: URL?
    @AppStorage("timerVolume") private var timerVolume = 0.5
    
    @EnvironmentObject var soundPlayer: CustomSoundPlayer

    @State var avAudioPlayer: AVAudioPlayer!

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
                Toggle("custom alarm sound", isOn: $useCustomTimerSound)
                
                if (!useCustomTimerSound) {
                    Picker(selection: $timerSound, label: Text("alarm sound")) {
                        Text("harp").tag(TimerSounds.harp)
                        Text("marimba").tag(TimerSounds.marimba)
                    }
                    .onChange(of: timerSound) { _ in
                        soundPlayer.setPremadeSound(timerSound.rawValue)
                        soundPlayer.play()
                    }
                }
                else {
                    HStack {
                        PomodoroSettingsAlarmSoundFileChooser(filepath: $customTimerSoundPath)
                        
                        Text(customTimerSoundPath?.lastPathComponent ?? "")
                        
                        Button {
                            soundPlayer.play()

                        } label: {
                            Image(systemName: "speaker.wave.2.fill")
                        }
                    }
                    .onChange(of: customTimerSoundPath) { _ in
                        soundPlayer.setSound(customTimerSoundPath)
                    }
                    .onAppear {
                        soundPlayer.setSound(customTimerSoundPath)
                    }
                    
                    
                }
                
                
                
                
                Slider(value: $timerVolume, onEditingChanged: { editing in
                    if (!editing) {
                        soundPlayer.setVolume(Float(timerVolume))
                        soundPlayer.play()
//
//                        stopAllManagedSounds()
//
//                        if (useCustomTimerSound) {
//                            avAudioPlayer.volume = Float(timerVolume)
//                        }
//                        play(sound: timerSound.rawValue + ".mp3", volume: timerVolume)
                        
                    }
                }) {
                    Text("volume")
                }
                
                
            }

        }
        
        
    }
}

struct PomodoroSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroSettingsView()
    }
}
