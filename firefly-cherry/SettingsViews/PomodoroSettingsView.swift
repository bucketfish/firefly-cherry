//
//  PomodoroSettingsView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import SwiftUI

struct PomodoroSettingsView: View {
    @AppStorage("pomodoroLength") private var pomodoroLength = 25
    @AppStorage("shortbreakLength") private var shortbreakLength = 5
    @AppStorage("longbreakLength") private var longbreakLength = 30

    @State var timerSoundIndex = 0
    
    var timerSounds = [
    "apple pie", "idk bro", "lemonade", "yasss"
    ]

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
            
            Section (header: Text("timer sound").bold()) {
                Picker(selection: $timerSoundIndex, label: Text("timer sound")) {
                    ForEach(0 ..< timerSounds.count) { count in
                        Text(self.timerSounds[count])
                    }
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
