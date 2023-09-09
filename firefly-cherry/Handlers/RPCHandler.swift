//
//  RPCHandler.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation
import SwordRPC

var rpc = SwordRPC(appId: "1148902945304363072")

var connected = false

func setupRPC(pomocount: Int, state: PomodoroState, countdownTime: Int = 0, paused: Bool = false, showPaused: Bool = true) {

    
    if (paused && !showPaused) {
        rpc.disconnect()
        connected = false
        return
    }
    
    
    if (!connected) {
        rpc = SwordRPC(appId: "1148902945304363072")
        print(rpc.connect())
        connected = true
    }
    
    //    rpc.onConnect { rpc in
    
    var presence = RichPresence()
    
    switch state {
    case .pomodoro:
        presence.details = "pomodoro timer" + (paused ? " / paused" : "")
    case .short_break:
        presence.details = "short break" + (paused ? " / paused" : "")
    case .long_break:
        presence.details = "long break" + (paused ? " / paused" : "")
    }
//
//    if (paused) {
//        presence.details += " / paused"
//    }
//
    
    presence.state = "\(String(repeating: "🍅", count: pomocount)) (\(String(pomocount)) of 4)"
    
    if (!paused) {
        presence.timestamps.start = Date() //Int(Date().timeIntervalSince1970)
        presence.timestamps.end = Date() + TimeInterval(countdownTime) //Int((Date() + TimeInterval(countdownTime)).timeIntervalSince1970) // 600s = 10m
        //        }
        
    }
    

    //      presence.assets.largeImage = "map1"
    //      presence.assets.largeText = "Map 1"
    //      presence.assets.smallImage = "character1"
    //      presence.assets.smallText = "Character 1"
    //      presence.party.max = 4
    //      presence.party.size = 1
    //      presence.party.id = "partyId"
    //      presence.secrets.match = "matchSecret"
    //      presence.secrets.join = "joinSecret"
    //      presence.secrets.joinRequest = "joinRequestSecret"
    
    rpc.setPresence(presence)

    
}

func disconnectRPC() {
    rpc.disconnect()
    connected = false
}





//
//    rpc.onDisconnect { rpc, code, msg in
//      print("It appears we have disconnected from Discord")
//    }
//
//    rpc.onError { rpc, code, msg in
//      print("It appears we have discovered an error!")
//    }
//
//    rpc.onJoinGame { rpc, secret in
//      print("We have found us a join game secret!")
//    }
//
//    rpc.onSpectateGame { rpc, secret in
//      print("Our user wants to spectate!")
//    }

//    rpc.onJoinRequest { rpc, request, secret in
//      print("Some user wants to play with us!")
//      print(request.username)
//      print(request.avatar)
//      print(request.discriminator)
//      print(request.userId)
//
//      rpc.reply(to: request, with: .yes) // or .no or .ignore
//    }


