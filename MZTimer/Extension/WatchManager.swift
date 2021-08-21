//
//  WatchManager.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation
import WatchConnectivity

class WatchManager :NSObject{
    
    static let shared: WatchManager = WatchManager()
    
    fileprivate var watchSession: WCSession?
    
    override init() {
        super.init()
        if (!WCSession.isSupported()) {
            watchSession = nil
            return
        }
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    func sendParamsToWatch(dict: [String: Any]) {
        do {
            try watchSession?.updateApplicationContext(dict)
        }catch {
            print("Error sending dictionary to apple watch \(dict)")
        }
    }
    
}
extension WatchManager: WCSessionDelegate {
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")

    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")

    }
    #endif

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
//        sendParamsToWatch(dict: ["category" : UserDefaultStorage.shared.loadCategory()])
    }

    
}
