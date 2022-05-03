//
//  MainView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
          TrashMobsNearYouView()
            .tabItem {
              Label("Near you", systemImage: "location")
            }
          SearchView()
            .tabItem {
              Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
