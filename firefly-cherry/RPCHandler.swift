//
//  RPCHandler.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation
import SwordRPC

let rpc = SwordRPC(appId: "1148902945304363072")

func setupRPC(pomocount: Int, state: PomodoroState, countdownTime: Int = 0, paused: Bool = false) {
    
//    rpc.onConnect { rpc in
        
      var presence = RichPresence()
        switch state {
        case .pomodoro:
            presence.details = "pomodoro timer"
        case .short_break:
            presence.details = "short break"
        case .long_break:
            presence.details = "long break"
        }
        
        if (paused) {
            presence.details += " / paused"
        }
        
//        presence.details += " (debug \(Date().timeIntervalSince1970))"
        
        presence.state = "\(String(repeating: "🍅", count: pomocount)) (\(String(pomocount)) of 4)"
        
        if (!paused) {
            presence.timestamps.start = Int(Date().timeIntervalSince1970)
            presence.timestamps.end = Int((Date() + TimeInterval(countdownTime)).timeIntervalSince1970) // 600s = 10m
//        }
        
        
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
            rpc.connect()
        
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

    

}

