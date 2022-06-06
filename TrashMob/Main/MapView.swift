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
            MapAnnotation(coordinate: trashMob.coordinate2D) {
                NavigationLink {
                                        TrashMobFullscreenView(trashMob: trashMob, user: User.testData[0])
                                    } label:
                {
                    TrashMobMapAnnotation(trashMobState: trashMob.trashMobState)
                }

////                    }
////                }
////
////                }
//
//
//                    }
                
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

