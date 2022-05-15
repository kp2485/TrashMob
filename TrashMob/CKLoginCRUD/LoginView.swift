//
//  LoginView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/25/22.
//

import SwiftUI
import CloudKit

class LoginViewModel: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedIntoiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserID()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedIntoiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
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
            }
        }
    }
}

struct LoginView: View {
    
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("TrashMob validates all users with their iCloud account")
                .font(.system(.title))
                .padding()
            Spacer()
//            Text("IS SIGNED IN: \(vm.isSignedIntoiCloud.description.uppercased())")
//            Text(vm.error)
//            Text("Permission: \(vm.permissionStatus.description.uppercased())")
//            Text("NAME: \(vm.userName)")
            Spacer()
            Text("Your name or email will not be shared or otherwise utilized without your permission")
                .padding()
                .font(.system(.title))
            Text("Posting improper pictures or otherwise disrespectful behavior may lead to the suspension or termination of your account")
            Spacer()
        }
        .multilineTextAlignment(.center)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
