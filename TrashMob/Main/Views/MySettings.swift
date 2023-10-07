//
//  MySettings.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI

struct MySettings: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var notificationsLoved = false
    @State var notificationsLocal = false
    @State var notificationsDistance: Double = 10.0
    @State var isEditingDistance = false
    @State var NeedAssistance = false
    var body: some View {
        
        NavigationView{
            
            Form{
                
                Section(header: Text("My Profile")) {
                    //                    HStack {
                    //                        Button {
                    //                            //  TakePictureView()
                    //                            print("Take profile Picture")
                    //                        } label: {
                    //                            Text("Take Profile Picture")
                    //                        }
                    //                    }
                    Text("Joined TrashMob: \(Date().addingTimeInterval(-2000000).formatted(.dateTime.month().day().year()))")
                    Text("Targets: \(userViewModel.user?.mobsTargetedCount ?? 0)")
                    Text("Loves: \(userViewModel.user?.mobsLovedCount ?? 0)")
                    Text("Commits: \(userViewModel.user?.mobsCommittedCount ?? 0)")
                    Text("Clean-ups: \(userViewModel.user?.mobsCompletedCount ?? 0)")
                    Text("Reliability: \(userViewModel.user?.reliability ?? 1.0)")
                    Text("Time spent: 12 hours, 33 minutes")
                }
                
                Section(header: Text("Notification Settings")) {
                    Toggle(isOn: $notificationsLoved, label: {
                        Text("Loved TrashMobs")
                    })
                    Toggle(isOn: $notificationsLocal, label: {
                        Text("New TrashMobs")
                    })
                    
                    Slider(value: $notificationsDistance, in: 1...50, onEditingChanged: { editing in
                        isEditingDistance = editing
                    })
                    HStack {
                        Spacer()
                        Text("TrashMobs within \(notificationsDistance) miles")
                            .foregroundColor(isEditingDistance ? .blue : .gray)
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text ("My Settings")
                            .font(.largeTitle)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(maxHeight: .infinity)
                    }
                }
            }
        }
    }
}

struct MySettings_Previews: PreviewProvider {
    static var previews: some View {
        MySettings()
    }
}
