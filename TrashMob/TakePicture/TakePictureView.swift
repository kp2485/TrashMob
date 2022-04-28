//
//  TakePictureView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/28/22.
//

import SwiftUI

struct TakePictureView: View {
    var body: some View {
        ZStack {
          Color.black.edgesIgnoringSafeArea(.all)

          Text("Filter the World!")
            .foregroundColor(.white)
        }
    }
}

struct TakePictureView_Previews: PreviewProvider {
    static var previews: some View {
        TakePictureView()
    }
}
