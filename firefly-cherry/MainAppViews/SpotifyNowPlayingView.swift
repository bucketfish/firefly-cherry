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
    
    @AppStorage("useCustomFont") private var useCustomFont = false
    @AppStorage("customFontName") private var customFontName = ""

    @AppStorage("showNextPrev") private var showNextPrev = true

    @State var songName = ""
    @State var songUrl = ""
    @State var spotifyRunning = true
    
    @State var isPlaying = false
    
    var body: some View {
        if (songName != "NOTRUNNING") {
            HStack (spacing: 4) {
                Group {
                    
                    if (showNextPrev) {
                        Button {
                            prevSong {
                                updateSongName()
                            }
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
                        .font(.custom(useCustomFont ? customFontName : "", size: 18, relativeTo: .title2))
                        .onAppear { periodicallyUpdateSongName() }
                    
                    Button {
                        toggleIsPlaying { returnIsPlaying in
                            isPlaying = returnIsPlaying.booleanValue
                        }

                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    
                    if (showNextPrev) {
                        Button {
                            nextSong {
                                updateSongName()
                            }
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
                .font(.custom(useCustomFont ? customFontName : "", size: 18, relativeTo: .title2))
                .foregroundColor(Color("PomodoroText"))
                .padding(.vertical, 5)
                .opacity(0.8)
        }
        
    }
    
    func updateSongName() {
        getSongName { result in
            songName = result.atIndex(1)?.stringValue ?? ""
            songUrl = result.atIndex(2)?.stringValue ?? ""
        }
        
        getIsPlaying { value in
            isPlaying = value.booleanValue
        }
        
    }
    func periodicallyUpdateSongName() {
        getPlaySongAccess()
        
        updateSongName()
        
        _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            if (!spotifyRunning) {
                timer.invalidate()
            }
            updateSongName()
        }
    }
}

struct SpotifyNowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyNowPlayingView()
    }
}
