//
//  MapView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var viewModel: MapViewModel
    @EnvironmentObject var vm: TrashMobViewModel
    @State var isAnimating: Bool = false
    
    @State private var isShowingDetails = false
    
    let flagImage = Image(systemName: "flag.fill")
    
    var body: some View {
        
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: vm.trashMobs) { trashMob in
            MapAnnotation(coordinate: trashMob.coordinate2D) {
                Button {
                    vm.selectedTrashMob = trashMob
                    isShowingDetails.toggle()
                } label: {
                    TrashMobMapAnnotation(trashMobState: trashMob.trashMobState)
                }
            }
        }
        .ignoresSafeArea()
        // dot color
        .accentColor(Color(.systemPink))
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
        .sheet(isPresented: $isShowingDetails) {
            TrashMobFullscreenView(user: User.testData[0])
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

