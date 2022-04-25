//
//  LoginView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/25/22.
//

import SwiftUI
import CloudKit

class LoginViewModel: ObservableObject {
    
    @Published var isSignedIntoiCloud: Bool = false
    @Published var error: String = ""
    
    init() {
        getiCloudStatus()
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
    
}

struct LoginView: View {
    
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("IS SIGNED IN: \(vm.isSignedIntoiCloud.description.uppercased())")
            Text(vm.error)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
