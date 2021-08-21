//
//  ViewModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation
import Combine

class ViewModel: NSObject, ObservableObject {

    @Published var categories: [Category] = UserDefaultStorage.shared.loadCategory()
    @Published var events: [Event] =  UserDefaultStorage.shared.loadEvent()
    @Published var contacts: [ContactModel] = UserDefaultStorage.shared.loadContact()

    @Published var currentObject: String = "There are currently no events"

    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(eventNotificationReceived), name: .EventUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(categoryNotificationReceived), name: .CategoryUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(contactNotificationReceived), name: .ContactUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didAppBecomeForegorundReceived), name: .AppEnterForeground, object: nil)
    }

    public func reloadData() {
        reloadEvents()
        reloadCategories()
        reloadContacts()
    }

    private func reloadEvents() {
        events.removeAll()
        events = UserDefaultStorage.shared.loadEvent()
    }
    private func reloadCategories(){
        categories.removeAll()
        categories = UserDefaultStorage.shared.loadCategory()
    }
    private func reloadContacts() {
        contacts.removeAll()
        contacts = UserDefaultStorage.shared.loadContact()
    }

    @objc func eventNotificationReceived() {
        reloadEvents()
    }
    @objc func categoryNotificationReceived() {
        reloadCategories()
    }
    @objc func contactNotificationReceived() {
        reloadContacts()
    }
    @objc func didAppBecomeForegorundReceived(_ notification: Notification) {
        if let eventInfo = notification.userInfo?["event"] as? Event {
            currentObject = eventInfo.emoji + eventInfo.title
        }
    }
}
