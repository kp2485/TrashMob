//
//  MySettings.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI

struct MySettings: View {
    @State var user = User.self
    @State var notificationsLoved = false
    @State var notificationsLocal = false
    @State var notificationsDistance: Double = 10.0
    @State var isEditingDistance = false
    @State var NeedAssistance = false
    var body: some View {
        
        NavigationView{
            
            Form{
                
                Section(header: Text("My Profile")) {
                    HStack {
                        
                        Button {
                            
                            //  TakePictureView()
                            print("Take profile Picture")
                        } label: {
                            Text("Take Profile Picture")
                        }
                            
                    }
                    
                    Text("Joined TrashMob: \(Date())")
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
//            .hiddenNavigationBarStyle()
        }
        .navigationTitle("My Settings")
        
        
    }
    
    
    
    struct MySettings_Previews: PreviewProvider {
        static var previews: some View {
            MySettings()
        }
    }
    
}
