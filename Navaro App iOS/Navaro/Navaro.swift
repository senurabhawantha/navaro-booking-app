//
//  Navaro.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI
import Firebase
import FirebaseAuth
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let action = userInfo["action"] as? String, action == "open_booking" {
            NotificationCenter.default.post(name: Notification.Name("OpenBookingScreen"), object: nil)
        }

        completionHandler()
    }
}

@main
struct NavaroApp: App {
    @StateObject var authViewModel = AuthViewModel()

    let notificationDelegate = NotificationDelegate()

    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            } else {
                print("Permission granted: \(granted)")
            }
        }

        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            print("Correct")
        }

        if Auth.auth().currentUser != nil {
            authViewModel.isAuthenticated = true
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
