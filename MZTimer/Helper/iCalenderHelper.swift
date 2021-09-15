//
//  iCalenderHelper.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/06/13.
//

import Foundation
import EventKit

class iCalenderHelper {

    static let shared = iCalenderHelper()

    let eventStore: EKEventStore!

    init() {
        eventStore = EKEventStore()
    }

    public func addEvent(event: iCalenderEvent) {
        if checkEventStorePermission() == false { return }
        insertEvent(store: eventStore, info: event)
    }

    public func checkEventStorePermission() -> Bool {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            return true
        case .denied:
            return false
        case .notDetermined:
            var permission = false
            requestEventStorePermission { isGranted in
                permission = isGranted
            }
            return permission
        default:
            return false
        }
    }

    private func requestEventStorePermission(completion: (Bool) -> Void) {
        var isGranted = false
        eventStore.requestAccess(to: .event, completion: {
            (granted: Bool, error: Error?) -> Void in
            isGranted = granted
        })
        completion(isGranted)
    }

    private func insertEvent(store: EKEventStore, info: iCalenderEvent) {
        let event:EKEvent = EKEvent(eventStore: store)
        event.title = info.title
        event.startDate = info.startDate
        event.endDate = info.endDate
        event.notes = info.note
        event.calendar = store.defaultCalendarForNewEvents
        do {
            try store.save(event, span: .thisEvent)
        } catch let error as NSError {
            print("failed to save event with error : \(error)")
        }
        print("Saved Event")
    }
}

struct iCalenderEvent {
    var title: String
    var startDate: Date
    var endDate: Date
    var note: String
    var time: Int

    init(title: String, note: String, time: Int, startDate: Date) {
        self.title = title
        self.note = note
        self.time = time
        self.startDate = startDate
        self.endDate = startDate.addingTimeInterval(TimeInterval(time))
    }
}
