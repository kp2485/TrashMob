//
//  TrashMobApp.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/24/22.
//

import SwiftUI
import AVFoundation

@main
struct TrashMobApp: App {
    
    
//    let persistenceController = PersistenceController.shared
    let currentUserIsSignedIn: Bool
    
    init() {
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        self.currentUserIsSignedIn = userIsSignedIn
        
    }

    var body: some Scene {
        WindowGroup {
//            TabsView()
//            TakePictureView()
//            CameraPreview(session: session)
//            MainView()
//            CloudKitPushNotifications()
            CloudKitCRUDView()
//            LoginView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
