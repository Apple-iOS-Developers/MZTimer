//
//  WatchManager.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation
import WatchConnectivity

enum WatchConnectivityResult: String {
    case isNotInstalled = "Companion watch app is not installed"
    case isNotReachable = "Companion watch app is not running"
    case sendMessageError = "Unknown watch app error"
    case success = "success"
}

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

    func isReachable() -> Bool {
        return watchSession.isReachable
    }

    func syncDataToWatch(completion: @escaping (WatchConnectivityResult) -> Void) {
        if !watchSession.isWatchAppInstalled {
            completion(.isNotInstalled)
            return
        }

        if watchSession.isReachable {
            let sampleData = ["data":"string from iphone"]
            try? watchSession.updateApplicationContext(sampleData)
            watchSession.sendMessage(sampleData, replyHandler: nil) { error in
                completion(.sendMessageError)
                print("[WatchManager] \(error.localizedDescription)")
            }
        } else {
            completion(.isNotReachable)
            return
        }
        completion(.success)
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
