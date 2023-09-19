//
//  TrashMobMapView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import MapKit
import SwiftUI

struct TrashMobMapView: View {
    @ObservedObject var TMviewModel: TrashMobMapViewModel
    @EnvironmentObject var vm: TrashMobViewModel
    @State var isAnimating: Bool = false
    
    @State private var isShowingDetails = false
    
    var body: some View {
        
        Map(coordinateRegion: $TMviewModel.region, showsUserLocation: true, annotationItems: vm.trashMobs) { trashMob in
            MapAnnotation(coordinate: trashMob.coordinate2D) {
                Button {
                    vm.selectedTrashMob = trashMob
                    isShowingDetails.toggle()
                } label: {
                    TrashMobMapAnnotation(trashMobState: trashMob.trashMobState)
                }
            }
        }
//        .ignoresSafeArea()
        // dot color
        .accentColor(Color(.systemPink))
        .onAppear {
            TMviewModel.checkIfLocationServicesIsEnabled()
        }
        .sheet(isPresented: $isShowingDetails) {
            TrashMobFullscreenView(user: User.testData[0])
        }
    }
}

struct TrashMobMapView_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobMapView(TMviewModel: TrashMobMapViewModel())
    }
}

