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
import EventKit

enum WatchConnectivityResult: String {
    case isNotInstalled = "Companion watch app is not installed"
    case isNotReachable = "Companion watch app is not running"
    case sendMessageError = "Unknown watch app error"
    case success = "success"
    case jsonEncodingError = "JSON encoding error"
}

class WatchViewModel: NSObject, ObservableObject {
    
    private var session: WCSession = WCSession.default
    private var cancellables = Set<AnyCancellable>()
    
    
    @State var showReceivedMessageAlert: Bool = false
    
    
    @Published var currentObject: String = "There are currently no events"
    @Published var categories: [Category] = WatchUserDefaultStorage.shared.loadCategory()
    @Published var events: [Event] =  WatchUserDefaultStorage.shared.loadEvent()
    @Published var contacts: [Contact] = WatchUserDefaultStorage.shared.loadContact()
    
    override init() {
        super.init()
        session.delegate = self
        session.activate()
        
        NotificationCenter.default.publisher(for: .EventUpdated).sink { _ in
            self.reloadEvents()
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: .CategoryUpdated).sink { _ in
            self.reloadCategories()
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: .ContactUpdated).sink { _ in
            self.reloadContacts()
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: .AppEnterForeground).sink { notification in
            if let eventInfo = notification.userInfo?["event"] as? Event {
                self.currentObject = eventInfo.emoji + eventInfo.title
            }
        }.store(in: &cancellables)
        
    }
    
    public func reloadData() {
        reloadEvents()
        reloadCategories()
        reloadContacts()
    }
    
    private func reloadEvents() {
        events.removeAll()
        events = WatchUserDefaultStorage.shared.loadEvent()
    }
    private func reloadCategories(){
        categories.removeAll()
        categories = WatchUserDefaultStorage.shared.loadCategory()
    }
    private func reloadContacts() {
        contacts.removeAll()
        contacts = WatchUserDefaultStorage.shared.loadContact()
    }
    
    public func sendEventDataToPhone(event: Event, completion: @escaping (WatchConnectivityResult) -> Void) {
        if !session.isCompanionAppInstalled {
            completion(.isNotInstalled)
            return
        }
        
        if session.isReachable {
            do {
                let encoder = JSONEncoder()
                let event = try encoder.encode(event)
                let message: [String: Any] = ["event":event]
                session.sendMessage(message, replyHandler: nil) { error in
                    completion(.sendMessageError)
                }
            } catch {
                completion(.jsonEncodingError)
                return
            }
        }
        else {
            completion(.isNotReachable)
            return
        }
        completion(.success)
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
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("[WatchViewModel] userInfo \(userInfo)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("[WatchViewModel] didReceiveMessage \(message)")
        showReceivedMessageAlert = true
        
        let decoder = JSONDecoder()
        
        let categories = try? decoder.decode([Category].self, from: message["categories"] as! Data)
        let events = try? decoder.decode([Event].self, from: message["events"] as! Data)
        let contacts = try? decoder.decode([Contact].self, from: message["contacts"] as! Data)
        
        DispatchQueue.main.async {
            WatchUserDefaultStorage.shared.syncDataWithiPhone (
                categories: categories ?? [],
                events: events ?? [],
                contacts: contacts ?? []
            )
        }
    }
}
