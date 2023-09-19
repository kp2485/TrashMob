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
    
    @State private var isShowingDetails = false

    var body: some View {
        List {
            
            ForEach(vm.trashMobs) { trashMob in
                
                Button {
                    //Action
                    vm.selectedTrashMob = trashMob
                    isShowingDetails.toggle()
                } label: {
                    rowView(trashMob: trashMob)
                }
            }
        }
        .sheet(isPresented: $isShowingDetails) {
            TrashMobFullscreenView(user: User.testData[0])
        }
    }
}

extension TrashMobList {
    private func rowView(trashMob: TrashMob) -> some View {
        HStack {
            VStack{
                if trashMob.trashMobState == "targeted" {
                    ZStack {
                        Circle()
                            .frame(width: 45)
                            .foregroundColor(.red)
                        Text("🎯").font(.title)
                    }
                } else if trashMob.trashMobState == "scheduling" {
                    ZStack {
                        Circle()
                            .frame(width: 45)
                            .foregroundColor(.yellow)
                        Text("📆").font(.title)
                    }
                } else if trashMob.trashMobState == "scheduled" {
                    ZStack {
                        Circle()
                            .frame(width: 45)
                            .foregroundColor(.green)
                        Text("✋").font(.title)
                    }
                } else if trashMob.trashMobState == "active" {
                    ZStack {
                        Circle()
                            .frame(width: 45)
                            .foregroundColor(.purple)
                        Text("🚮").font(.title)
                    }
                } else if trashMob.trashMobState == "completed" {
                    ZStack {
                        Circle()
                            .frame(width: 45)
                            .foregroundColor(.blue)
                        Text("✨").font(.title)
                    }
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

struct TrashMobList_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobList()
    }
}
