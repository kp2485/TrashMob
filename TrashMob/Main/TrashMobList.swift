//
//  TrashMobList.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/7/22.
//

import SwiftUI
import MapKit

struct TrashMobList: View {
    
    @EnvironmentObject var vm: TrashMobViewModel
    @EnvironmentObject var viewModel: MapViewModel

    var body: some View {
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

                        if let location = viewModel.locationManager?.location {
                            Text(trashMob.distance(to: location))
                                .font(.body)
                                .fontWeight(.light)
                                .lineLimit(1)
                        }
                        

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
}

struct TrashMobList_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobList()
    }
}
