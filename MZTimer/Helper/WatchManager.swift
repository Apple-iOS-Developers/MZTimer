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

    fileprivate var watchSession = WCSession.default

    override init() {
        super.init()
        if WCSession.isSupported() {
            watchSession.delegate = self
            watchSession.activate()
        }
    }

    func syncDataToWatch() {
        if watchSession.isWatchAppInstalled {
            print("[WatchManager] watch app is installed")
        } else {
            print("[WatchManager] watch app is NOT installed")
            return
        }

        print("[WatchManager] activationState \(watchSession.activationState.rawValue)")
        if watchSession.isReachable {
            let sampleData = ["data":"string from iphone"]
            try? watchSession.updateApplicationContext(sampleData)
            watchSession.sendMessage(sampleData, replyHandler: nil) { error in
                print("[WatchManager] \(error.localizedDescription)")
            }
        } else {
            print("[WatchManager] inValid Session!")
        }
    }

}
extension WatchManager: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("[WatchManager] activationDidComplete \(error?.localizedDescription)")
//        sendParamsToWatch(dict: ["category" : UserDefaultStorage.shared.loadCategory()])
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("[WatchManager] sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("[WatchManager] sessionDidDeactivate")
    }



    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("[WatchManager] received Message \(message)")
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("[WatchManager] received data \(userInfo)")
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("[WatchManager] received data \(applicationContext)")
    }

}
