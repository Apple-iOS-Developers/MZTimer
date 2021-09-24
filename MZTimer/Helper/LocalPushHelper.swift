//
//  LocalPushHelper.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/09/24.
//

import Foundation
import UserNotifications

class LocalPushHelper {
    
    static let shared: LocalPushHelper = LocalPushHelper()
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    init() {
        requestNotificationAuthorization()
    }
    
    private func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    public func sendNotification(event: Event) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "MZTimer"
        notificationContent.body = "\(event.emoji)\(event.title) was started at \(event.startDate.dateWithTimeSecondsString())"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
