//
//  MZTimerApp.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

@main
struct MZTimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
