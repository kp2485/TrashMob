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
    @StateObject var vm = TrashMobViewModel()
    @StateObject var viewModel = MapViewModel()
    @StateObject var TMviewModel = TrashMobMapViewModel()
    
    
//    let persistenceController = PersistenceController.shared
    let currentUserIsSignedIn: Bool
    
    init() {
        _vm = StateObject(wrappedValue: TrashMobViewModel())
        _viewModel = StateObject(wrappedValue: MapViewModel())
        _TMviewModel = StateObject(wrappedValue: TrashMobMapViewModel())
        
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        self.currentUserIsSignedIn = userIsSignedIn
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
//            TabsView()
//            TrashMobFullscreenView(referenceDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!)
//            TakePictureView()
//            CameraView()
//            MainView()
//            CloudKitPushNotifications()
//            CloudKitCRUDView()
//            LoginView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(vm)
                .environmentObject(viewModel)
                .environmentObject(TMviewModel)
        }
    }
}
