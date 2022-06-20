//
//  LoginView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/20/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("TrashMob validates all participants with their iCloud account")
                    .font(.system(.title))
                    .padding()
                Spacer()
                
                if userViewModel.isSignedIntoiCloud == false {
                    Text("IS SIGNED IN: \(userViewModel.isSignedIntoiCloud.description.uppercased())")
                    Text(userViewModel.error)
                    Text("Permission: \(userViewModel.permissionStatus.description.uppercased())")
                } else {
                    Text("Welcome, \(userViewModel.userName)!")
                        .font(.largeTitle)
                }
                
                Spacer()
                Text("""
Only your first name
will be shared
with fellow trash mobbers
""")
                .padding()
                .font(.system(.title))
                Text("Posting improper pictures or otherwise disrespectful behavior may lead to the suspension or termination of your TrashMob account")
                //            Spacer()
                NavigationLink("Go home!") {
                    SplashView()
                }
            }
            .multilineTextAlignment(.center)
        }
        
    }
}
