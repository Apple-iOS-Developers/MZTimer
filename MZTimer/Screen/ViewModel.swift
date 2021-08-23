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
    
    var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        
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
}
