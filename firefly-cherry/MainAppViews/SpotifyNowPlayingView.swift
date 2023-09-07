//
//  SpotifyNowPlayingView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct SpotifyNowPlayingView: View {
    @AppStorage("customColor") private var customColorString: String = ""

    
    @State var songName = ""
    @State var spotifyRunning = true
    
    var body: some View {
        HStack {
            
            Group {
                
                Button {
                    
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                }
                .buttonStyle(.plain)
                .padding(.leading, 5)
                
                Text("\(songName)")
                    .font(.title2)
                    .onAppear { periodicallyUpdateSongName() }
                
                Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title2)
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 5)
                    
            }
            
            .padding(.vertical, 5)
            
        }
        .foregroundColor(Color("PomodoroText"))
//        .background(stringToColor(string: customColorString))
        .cornerRadius(10)
        
        
    }
    
    func periodicallyUpdateSongName() {
        getSongName { result in
            songName = result
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            
            if (!spotifyRunning) {
                timer.invalidate()
            }
            
            getSongName { result in
                songName = result
            }

        }
    }
}

struct SpotifyNowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyNowPlayingView()
    }
}
