//
//  swift_dating_firebaseApp.swift
//  swift-dating-firebase
//
//  Created by Danh Tu on 13/09/2021.
//

import SwiftUI
import Firebase

@main
struct swift_dating_firebaseApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Connecting Firebase
class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
