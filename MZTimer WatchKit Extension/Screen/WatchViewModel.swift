//
//  WatchViewModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation
import WatchConnectivity
import SwiftUI

class WatchViewModel: NSObject, ObservableObject {
 
    var session: WCSession
    
    @Published var category: [Category] = [Category(emoji: "🟣", title: "oijwaef"),Category(emoji: "🟣", title: "oijwaef"),Category(emoji: "🟣", title: "oijwaef")]
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
   
 
    
}
extension WatchViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")

    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")

    }
    #endif
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let category = message["category"] as! [Category]
        DispatchQueue.main.async {
            self.category = category
        }
    }
}
