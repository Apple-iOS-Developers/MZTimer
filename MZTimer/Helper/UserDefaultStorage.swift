//
//  UserDefaultStorage.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation
import UIKit

class UserDefaultStorage {
    
    static let shared = UserDefaultStorage()
    
    init() {
        if category.count == 0 {
            category.append(Category(emoji: "📕", title: "예시 카테고리"))
        }
        
        if event.count == 0 {
            event.append(Event(emoji: "🔍", title: "예시 이벤트 입니다.", time: 100000, endDate: Date()))
        }
        
        if contact.count == 0 {
            contact.append(Contact(name: "예시 연락처 입니다.", phoneNumber: "010-XXXX-XXXX", memo: "예시 친구"))
        }
    }
    
    private var category: [Category] {
        get {
            var category: [Category]?
            if let data = UserDefaults.standard.value(forKey: "category") as? Data {
                category = try? PropertyListDecoder().decode([Category].self, from: data)
            }
            return category ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "category")
        }
    }
    private var event: [Event] {
        get {
            var event: [Event]?
            if let data = UserDefaults.standard.value(forKey: "event") as? Data {
                event = try? PropertyListDecoder().decode([Event].self, from: data)
            }
            return event ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "event")
        }
    }
    private var contact: [Contact] {
        get {
            var contact: [Contact]?
            if let data = UserDefaults.standard.value(forKey: "contact") as? Data {
                contact = try? PropertyListDecoder().decode([Contact].self, from: data)
            }
            return contact ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "contact")
        }
    }
    
    
    public func loadCategory()-> [Category] {
        return category
    }
    public func saveCategory(category: Category) {
        self.category.append(category)
        updateCategory()
    }
    public func deleteCategoryAll(){
        self.category.removeAll()
        updateCategory()
    }
    public func removeCategory(category: Category) {
        if let index = self.category.firstIndex(of: category) {
            self.category.remove(at: index)
            updateCategory()
        }
    }
    public func updateCategory(before: Category, after: Category) {
        if let index = self.category.firstIndex(of: before) {
            self.category[index] = after
            updateCategory()
        }
    }
    public func checkCategoryDuplicated(category: Category) -> Bool {
        return self.category.contains(category) ? true : false
    }
    
    
    public func loadEvent()-> [Event] {
        return event
    }
    public func saveEvent(event: Event) {
        if event.time < Int(UserDefaults.standard.string(forKey: "MinimumTime") ?? "5") ?? 5 {
            print("이벤트 시간 짧아서 무시")
            return
        }
        
        self.event.append(event)
        updateEvent()

        if UserDefaults.standard.bool(forKey: "SendMessage") {
            iMessageHelper.makeMessage(event: event)
        }
        if UserDefaults.standard.bool(forKey: "AddCalender") {
            let event = iCalenderEvent(event: event, note: "From MZTimer")
            iCalenderHelper.shared.addEvent(event: event)
        }
    }
    public func deleteEventAll(){
        self.event.removeAll()
        updateEvent()
    }
    public func removeEvent(event: Event) {
        if let index = self.event.firstIndex(of: event) {
            self.event.remove(at: index)
            updateEvent()
        }
    }

    
    func saveContact(contact: Contact) {
        self.contact.append(contact)
        updateContact()
    }
    func loadContact() -> [Contact]{
        return contact
    }
    func removeContact(contact: Contact) {
        if let index = self.contact.firstIndex(of: contact) {
            self.contact.remove(at: index)
            updateContact()
        }
    }

    private func updateEvent() {
        NotificationCenter.default.post(name:.EventUpdated,object: nil)
    }
    private func updateCategory() {
        NotificationCenter.default.post(name: .CategoryUpdated, object: nil)
    }
    private func updateContact() {
        NotificationCenter.default.post(name: .ContactUpdated, object: nil)
    }


}
extension Notification.Name {
    static let CategoryUpdated = Notification.Name("CategoryUpdated")
    static let EventUpdated = Notification.Name("EventUpdated")
    static let ContactUpdated = Notification.Name("ContactUpdated")
    static let AppEnterForeground = Notification.Name("AppEnterForeground")
}

extension UserDefaultStorage {
    public func getTotalTime(category: Category) -> Int {
        return self.event.filter{ $0.title == category.title }.reduce(0) { $0 + $1.time }
    }
    public func getRecentEvent(category: Category) -> Event? {
        return self.event.filter{ $0.title == category.title }.last
    }
    public func getDoneCount(category: Category) -> Int? {
        return self.event.filter{ $0.title == category.title }.count
    }
    public func getRelatedEvent(category:Category) -> [Event] {
        return self.event.filter{ $0.title == category.title }
    }
}
