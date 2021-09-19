//
//  WatchViewModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation
import WatchConnectivity
import SwiftUI
import Combine

class WatchViewModel: NSObject, ObservableObject {

    var session: WCSession = WCSession.default

    @Published var categories: [Category] = [Category(emoji: "🟣", title: "oijwaef")]

    @State var showReceivedMessageAlert: Bool = false

    override init() {
        super.init()
        session.delegate = self
        session.activate()
    }

    func sendDataToiPhone() {
        let sampleData = ["data":"string from apple watch"]
        session.sendMessage(sampleData, replyHandler: nil, errorHandler: nil)
    }
}
extension WatchViewModel: WCSessionDelegate {
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
        print("[WatchViewModel] activationDidCompleteWith")
        if activationState == WCSessionActivationState.activated {
            NSLog("Activated")
            if(session.isReachable){
                do {
                    try session.updateApplicationContext(
                        ["WatchRequestKey" : "updateData"]
                    )
                }
                catch let error as NSError {
                    print("\(error.localizedDescription)")
                }
            }
        }

        if activationState == WCSessionActivationState.inactive {
            NSLog("Inactive")
        }

        if activationState == WCSessionActivationState.notActivated {
            NSLog("NotActivated")
        }
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("[WatchViewModel] sessionDidBecomeInactive")

    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("[WatchViewModel] sessionDidDeactivate")
    }
    #endif

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        categories.append(Category(emoji: "🟣", title: "testfrom"))
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("[WatchViewModel] userInfo \(userInfo)")
        categories.append(Category(emoji: "🟣", title: "testfrom"))
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("[WatchViewModel] didReceiveMessage \(message)")
        showReceivedMessageAlert = true

        let decoder = JSONDecoder()

        let categories = try? decoder.decode([Category].self, from: message["categories"] as! Data)
//        let events = decoder.decode([Event].self, from: message["events"])
//        let contacts = decoder.decode([Contact].self, from: message["contacts"])
        self.categories = categories ?? []
    }
}
