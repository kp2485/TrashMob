//
//  TakePictureView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/28/22.
//

import SwiftUI

struct TakePictureView: View {
    
    @StateObject private var model = TakePictureViewModel()
    
    var body: some View {
        ZStack {
            FrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            ErrorView(error: model.error)
            ControlView(
                comicSelected: $model.comicFilter,
                monoSelected: $model.monoFilter,
                crystalSelected: $model.crystalFilter)
        }
    }
}

struct TakePictureView_Previews: PreviewProvider {
    static var previews: some View {
        TakePictureView()
    }
}
