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
    
    let flagImage = Image(systemName: "flag.fill")
    
    var body: some View {
        
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: trashMobs) { trashMob in
            MapAnnotation(coordinate: trashMob.coordinate) {
                NavigationLink {
//                    TrashMobFullscreenView(trashMob: trashMob, user: User.testData[0], attended: trashMob.attended, loved: trashMob.loved, nowDate: Date(), referenceDate: Date().addingTimeInterval(100))
                } label: {
                if trashMob.trashMobState == "targeted" {
                    ZStack {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption)
                                .foregroundColor(.red)
                                .offset(x: 0, y: -6)
                        }
                        .shadow(color: .primary, radius: 1, x: 2, y: 2)
                        Image(systemName: "target")
                            .foregroundColor(.white)
                            .offset(y: -7)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                    
                } else if trashMob.trashMobState == "scheduling" {
                    ZStack {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.title)
                                .foregroundColor(.orange)
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .offset(x: 0, y: -6)
                        }
                        .shadow(color: .primary, radius: 1, x: 2, y: 2)
                        Text("📆")
                            .font(.caption)
                            .offset(y: -7)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                } else if trashMob.trashMobState == "scheduled" {
                    ZStack {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.title)
                                .foregroundColor(.yellow)
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                                .offset(x: 0, y: -6)
                        }
                        .shadow(color: .primary, radius: 1, x: 2, y: 2)
                        Text("⏳")
                            .font(.caption)
                            .offset(y: -7)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                } else if trashMob.trashMobState == "active" {
                    ZStack {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption)
                                .foregroundColor(.green)
                                .offset(x: 0, y: -6)
                        }
                        .shadow(color: .primary, radius: 1, x: 2, y: 2)
                        Image(systemName: "hands.sparkles.fill")
//                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -7)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                } else if trashMob.trashMobState == "completed" {
                    ZStack {
                        VStack {
                            Image(systemName: "circle.fill")
                                .font(.title)
                                .foregroundColor(.cyan)
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.caption)
                                .foregroundColor(.cyan)
                                .offset(x: 0, y: -6)
                        }
                        .shadow(color: .primary, radius: 1, x: 2, y: 2)
                        Image(systemName: "sparkles")
//                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(y: -6)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                }
                
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

