//
//  MapView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    @State var isAnimating: Bool = false
    
    var trashMobs: [TrashMob]
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: trashMobs) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                
                // Insert conditional symbols based on trashMobState
                
//                                    Image(systemName: "location.magnifyingglass")
//                                        .frame(width: 30, height: 30)
//                                        .offset(x: 2, y: 2)
//                                        .foregroundColor(.primary)
//                Circle()
//                    .strokeBorder(Color.blue, lineWidth: isAnimating ? 5:1)
//                    .animation(.linear(duration: 1.5).repeatForever(), value: isAnimating)
//                    .frame(width: 30, height: 30)
//                    .onAppear {
//                        isAnimating = true
//                    }
                
                if annotation.trashMobState == "targeted" {
                    Text("🎯").font(.title)
                } else if annotation.trashMobState == "scheduling" {
                    Text("📆").font(.title)
                } else if annotation.trashMobState == "scheduled" {
                    Text("📅").font(.title)
                } else if annotation.trashMobState == "active" {
                    Text("🚮").font(.title)
                } else if annotation.trashMobState == "completed" {
                    Text("✨").font(.title)
                }
                
                
            }
        }
        .ignoresSafeArea()
        // dot color
        .accentColor(Color(.systemPink))
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(trashMobs: TrashMob.testData)
    }
}

