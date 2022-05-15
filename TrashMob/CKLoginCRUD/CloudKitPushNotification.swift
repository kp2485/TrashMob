//
//  CloudKitPushNotification.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/11/22.
//

import SwiftUI
import CloudKit

class CloudKitPushNotificationsViewModel: ObservableObject {
    
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error)
            } else if success {
                print("Notification permission success!")
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            } else {
                print("Notification permission failure :(")
            }
        }
    }
    
    func subscribeToNotifications() {
        
        // change value: true to loves > 50
        let predicate = NSPredicate(value: true)
        
        let subscription = CKQuerySubscription(recordType: "Mobs", predicate: predicate, subscriptionID: "trashMob_added_to_database", options: .firesOnRecordCreation)
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = "There's a new TrashMob!"
        notification.alertBody = "Open your app to see!"
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully subscribed to notifications!")
                print(returnedSubscription as Any)
            }
        }
    }
    
    func unsubscribeToNotifications() {
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "trashMob_added_to_database") { returnedID, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Successfully unsubscribed!")
                print(returnedID as Any)
            }
        }
    }
    
    func fetchSubscriptions() {
        CKContainer.default().publicCloudDatabase.fetchAllSubscriptions { sub, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print(sub as Any)
            }
        }
    }
}
    
    struct CloudKitPushNotifications: View {
        
        @StateObject private var vm = CloudKitPushNotificationsViewModel()
        
        var body: some View {
            VStack(spacing: 40) {
                
                Button("Request Notification Permissions") {
                    vm.requestNotificationPermissions()
                }
                
                Button("Subscribe to Notifications") {
                    vm.subscribeToNotifications()
                }
                
                Button("Unsubscribe to Notifications") {
                    vm.unsubscribeToNotifications()
                }
                
                Button("Fetch Subscriptions") {
                    vm.fetchSubscriptions()
                }
            }
            
        }
    }
    
    struct CloudKitPushNotifications_Previews: PreviewProvider {
        static var previews: some View {
            CloudKitPushNotifications()
        }
    }
