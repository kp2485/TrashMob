//
//  ContentView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: TrashMobViewModel
    @EnvironmentObject var viewModel: MapViewModel
    
    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var isTargetATrashMobShowing = false
    @State private var isMySettingsShowing = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    MapView()
                    TrashMobList()
                }
                .navigationBarTitleDisplayMode(.inline)
                .opacity(0.90)
                .edgesIgnoringSafeArea(.bottom)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Button(action: {
                                isMySettingsShowing = true
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title3)
                            }
                            
                            Spacer()
                            
                            Text ("TrashMob")
                                .font(.largeTitle)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .frame(maxHeight: .infinity)
                            
                            Spacer()
                            
                            Button(action: {
                                isTargetATrashMobShowing = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.title3)
                            }
                        }
                        .background()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isTargetATrashMobShowing) {
            CameraView()
        }
        .sheet(isPresented: $isMySettingsShowing) {
            MySettings()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.sizeCategory, .medium)
        
        ContentView()
        
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
