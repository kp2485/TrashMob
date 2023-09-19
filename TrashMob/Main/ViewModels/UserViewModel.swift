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
    
    @Published var user: User? {
        didSet {
            updateUser()
        }
    }
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
    //TODO: write CloudKit fetch/check user function? unless it knows
    
    func fetchUser(id: CKRecord.ID) {
        let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        let query = CKQuery(recordType: "User", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedUser: [User] = []
        
        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                    print("We got user")
                    let user = User.convertUser(from: record)
                    returnedUser.append(user)
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                let user = User.convertUser(from: returnedRecord)
                returnedUser.append(user)
            }
        }
        
        if #available(iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED queryResultBlock: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.user?.id = returnedUser[0].id
                }
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnedError) in
                print("RETURNED queryCompletionBlock")
                DispatchQueue.main.async {
                    self?.user?.id = returnedUser[0].id
                }
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
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
                let user = User(id: id, record: CKRecord(recordType: "User", recordID: id), userName: self?.userName, email: self?.email, joinDate: Date(), premiumStatus: false, mobsTargeted: [], mobsLoved: [], mobsCommitted: [], mobsCompleted: [], totalMobTime: 0.0, profilePicture: nil, notificationsLoved: false, notificationsLocal: false, notificationsDistance: 10.0)
                self?.user = user
            }
        }
        
    //TODO: call CloudKit adduser function
        
    }
    
    private func updateUser() {
        let newUser = CKRecord(recordType: "User")
        if let record = user?.record {
            record["userName"] = user?.userName ?? "Anonymous"
            record["email"] = user?.email ?? ""
            record["joinDate"] = user?.joinDate ?? Date()
            record["premiumStatus"] = user?.premiumStatus ?? false
            record["mobsTargeted"] = Array(user?.mobsTargeted ?? Set<CKRecord.ID>()) as NSArray
            record["mobsLoved"] = Array(user?.mobsLoved ?? Set<CKRecord.ID>()) as NSArray
            record["mobsCommitted"] = Array(user?.mobsCommitted ?? Set<CKRecord.ID>()) as NSArray
            record["mobsCompleted"] = Array(user?.mobsCompleted ?? Set<CKRecord.ID>()) as NSArray
            record["totalMobTime"] = Double(user?.totalMobTime ?? 0.0)
//            record["profilePicture"] = user?.profilePicture ?? URL(string: "https://www.pngfind.com/pngs/m/676-6764065_default-profile-picture-transparent-hd-png-download.png")
            
        }
        
            saveUser(record: newUser)
        
    }
    
    private func saveUser(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            
//            // delay for peeps with slow internet
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self?.fetchUser()
//            }
        }
    }
}
