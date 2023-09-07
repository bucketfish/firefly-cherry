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
    @State var songUrl = ""
    @State var spotifyRunning = true
    
    var body: some View {
        if (songName != "NOTRUNNING") {
            HStack {
                Group {
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    .padding(.leading, 5)
                    
                   
                    AsyncImage(url: URL(string: songUrl)) { image in
                        image

                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .cornerRadius(5)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text("\(songName)")
                        .font(.title2)
                        .onAppear { periodicallyUpdateSongName() }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "play.fill")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 5)
                    
                }
                
                .padding(.vertical, 5)
                
            }
            .foregroundColor(Color("PomodoroText"))
            .cornerRadius(10)
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
