//
//  LoginView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/25/22.
//

import SwiftUI
import CloudKit
import Combine

class LoginViewModel: ObservableObject {
    
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
    
    func getCurrentUserName() {
        CloudKitUtility.discoverUserIdentity()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] returnedName in
                self?.userName = returnedName
            }
            .store(in: &cancellables)
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
            Text("IS SIGNED IN: \(vm.isSignedIntoiCloud.description.uppercased())")
            Text(vm.error)
            Text("Permission: \(vm.permissionStatus.description.uppercased())")
            Text("NAME: \(vm.userName)")
            Spacer()
            Text("Your name or email will not be shared or otherwise utilized without your permission")
                .padding()
                .font(.system(.title))
            Text("Posting improper pictures or otherwise disrespectful behavior may lead to the suspension or termination of your account")
//            Spacer()
        }
        .multilineTextAlignment(.center)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
