//
//  SpotifyNowPlayingView.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import SwiftUI

struct SpotifyNowPlayingView: View {
    @AppStorage("cornerRadius") private var cornerRadius: Double = 10
    @AppStorage("customColor") private var customColorString: String = ""
    
    @AppStorage("showNextPrev") private var showNextPrev = true

    @State var songName = ""
    @State var songUrl = ""
    @State var spotifyRunning = true
    
    var body: some View {
        if (songName != "NOTRUNNING") {
            HStack (spacing: 4) {
                Group {
                    
                    if (showNextPrev) {
                        Button {
                            
                        } label: {
                            Image(systemName: "backward.fill")
                                .font(.title3)
                        }
                        .buttonStyle(.plain)
                    }
                    
                   
                    AsyncImage(url: URL(string: songUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .cornerRadius(cornerRadius / 2)
                    } placeholder: {}
                    
                    Text("\(songName)")
                        .font(.title2)
                        .onAppear { periodicallyUpdateSongName() }
                    
                    Button {

                    } label: {
                        Image(systemName: "play.fill")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    
                    if (showNextPrev) {
                        Button {
                            
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(.title3)
                        }
                        .buttonStyle(.plain)
                    }
                    
                }
                
            }
            .foregroundColor(Color("PomodoroText"))
            .opacity(0.8)
        }
        else {
            Text("spotify is not running!")
                .font(.title2)
                .foregroundColor(Color("PomodoroText"))
                .padding(.vertical, 5)
                .opacity(0.8)
            
        }
        
        
    }
    
    func periodicallyUpdateSongName() {
        getPlaySongAccess()
        
        getSongName { result in
            songName = result.atIndex(1)?.stringValue ?? ""
            songUrl = result.atIndex(2)?.stringValue ?? ""
            
            print(songUrl)

//            songName = result
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            
            if (!spotifyRunning) {
                timer.invalidate()
            }
            
            getSongName { result in
                songName = result.atIndex(1)?.stringValue ?? ""
                songUrl = result.atIndex(2)?.stringValue ?? ""
            }

        }
    }
}

struct SpotifyNowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyNowPlayingView()
    }
}
