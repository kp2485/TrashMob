//
//  UserViewModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/15/22.
//

import SwiftUI
import UIKit
import CloudKit
import Combine

class UserViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var email: String?
    @Published var permissionStatus: Bool = false
    @Published var isSignedIntoiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserID()
    }
    
    private func getiCloudStatus() {
        
        CloudKitUtility.getiCloudStatus()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.isSignedIntoiCloud = success
            }
            .store(in: &cancellables)
    }
    
    func requestPermission() {
        
        CloudKitUtility.requestApplicationPermission()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] success in
                self?.permissionStatus = success
            }
            .store(in: &cancellables)
    }
    
//    func getCurrentUserName() {
//        CloudKitUtility.discoverUserIdentity()
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self?.error = error.localizedDescription
//                }
//            } receiveValue: { [weak self] returnedName in
//                self?.userName = returnedName
//            }
//            .store(in: &cancellables)
//    }
    
    func fetchiCloudUserID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id  = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
                if let email = returnedIdentity?.lookupInfo?.emailAddress{
                    self?.email = email
                }
                let user = User(id: id, userName: self?.userName, email: self?.email, joinDate: Date(), premiumStatus: false, mobsTargeted: [], mobsLoved: [], mobsCommitted: [], mobsCompleted: [], totalMobTime: 0.0, profilePicture: nil, notificationsLoved: false, notificationsLocal: false, notificationsDistance: 0.0, notificationsLiked: false)
                self?.user = user
            }
        }
    }
}
