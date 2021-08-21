//
//  EventModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import Foundation

struct Event: Hashable, Codable {
    let uuid : UUID
    let emoji : String
    let title: String
    let time: Int
    let startDate: Date
    let endDate: Date
    
    init(emoji: String, title: String, time: Int, startDate: Date) {
        self.emoji = emoji
        self.title = title
        self.time = time
        self.startDate = startDate
        self.endDate = startDate.calculateEndDate(startDate: startDate, passedTime: time)
        self.uuid = UUID()
    }

    init(emoji: String, title: String, time: Int, endDate: Date) {
        self.emoji = emoji
        self.title = title
        self.time = time
        self.startDate = endDate.calculateStartDate(endDate: endDate, passedTime: time)
        self.endDate = endDate
        self.uuid = UUID()
    }
}
extension DateFormatter {
    func myFormattedString_DateTime(date: Date) -> String {
        self.dateFormat = "yyyy.MM.dd HH:mm"
        return self.string(from: date)
    }

    func myFormattedString_Date(date: Date) -> String {
        self.dateFormat = "yyyy.MM.dd"
        return self.string(from: date)
    }
}
extension Date {
    func calculateStartDate(endDate: Date ,passedTime: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: -passedTime, to: endDate) ?? Date()
    }
    func calculateEndDate(startDate: Date, passedTime: Int) -> Date {
        return startDate.addingTimeInterval(TimeInterval(passedTime))
    }

    func dateWithTimeString() -> String {
        return DateFormatter().myFormattedString_DateTime(date: self)
    }
    func dateWithoutTimeString() -> String {
        return DateFormatter().myFormattedString_Date(date: self)
    }
}
extension Int {
    func convertTimeToString() -> String {
        let seconds = String( (self % 3600) % 60 )
        let minutes = String( (self % 3600) / 60 )
        let  hours = String( (self / 3600)  )

        if hours != "0" && minutes != "0" {
            return "\(hours)h \(minutes)m \(seconds)s"
        }
        if minutes != "0" {
            return "\(minutes)min \(seconds)sec"
        }
        return "\(seconds) seconds"

    }
}
