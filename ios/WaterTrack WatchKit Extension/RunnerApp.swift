//
//  RunnerApp.swift
//  WaterTrack WatchKit Extension
//
//  Created by Sam Svindland on 7/31/22.
//

import SwiftUI

@main
struct RunnerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
