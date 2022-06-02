//
//  ContentView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: TrashMobViewModel
    
    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var isPlanAWalkShowing = false
    @State private var isMySettingsShowing = false
    
    var body: some View {
        NavigationView {
        VStack {
            
                VStack {
                    
                    Spacer()
                        .frame(height: screenHeight * 0.005)
                    
                    MapView(trashMobs: vm.trashMobs)
                        
//
//                    Text("Nearby TrashMobs")
//                        .font(.title)
//                        .fontWeight(.medium)
//                        .padding(.horizontal)
//                        .padding(.vertical, 1)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.5)
                    
                    List {
                        ForEach(vm.trashMobs) { trashMob in
                            NavigationLink(destination: TrashMobFullscreenView(trashMob: trashMob, user: User.testData[0])) {
                                HStack {
                                    VStack{
                                        if trashMob.trashMobState == "targeted" {
                                            Text("🎯").font(.title)
                                        } else if trashMob.trashMobState == "scheduling" {
                                            Text("📆").font(.title)
                                        } else if trashMob.trashMobState == "scheduled" {
                                            Text("📅").font(.title)
                                        } else if trashMob.trashMobState == "active" {
                                            Text("🚮").font(.title)
                                        } else if trashMob.trashMobState == "completed" {
                                            Text("✨").font(.title)
                                        }
                                            
                                    }
                                    VStack {
                                        HStack {
                                            
                                            
                                            Text(trashMob.trashMobState.capitalizingFirstLetter())
                                                .font(.title2)
                                                .layoutPriority(1)
                                                .lineLimit(2)
                                            
                                            Spacer()
                                            
                                            
                                        }
                                        .minimumScaleFactor(0.5)
                                        
                                        HStack {
                                            Text("Initiated by \(trashMob.targetingUser)")
                                                .font(.caption)
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                    Text("0.2 m")
                                        .font(.body)
                                        .fontWeight(.light)
                                        .lineLimit(1)
                                }
                            }
                        }
                        
                        
                        //                        HStack {
                        //                            Spacer()
                        //                            Text("See more...")
                        //                            Spacer()
                        //                        }
                    }
                    .onAppear(perform: {
                        UITableView.appearance().contentInset.top = -15
                    })
                    
                    
                    
                    
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
                                isPlanAWalkShowing = true
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
        .sheet(isPresented: $isPlanAWalkShowing) {
            TargetATrashMob(trashMobs: $vm.trashMobs)
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
