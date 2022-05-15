//
//  TabView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/13/22.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab = "Targeted"
    
    @StateObject var model = CameraService()

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Targeted")
                .onTapGesture {
                    selectedTab = "Targeted"
                }
                .tabItem {
                    Label("Targeted", systemImage: "target")
                }
                .tag("Targeted")
            
            Text("Mobbed")
                .tabItem {
                    Label("Mobbed", systemImage: "hands.sparkles")
                }
                .tag("Mobbed")
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
