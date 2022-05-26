//
//  TrashMobBackgroundImage.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/16/22.
//

import SwiftUI

struct TrashMobBackgroundImage: View {
    @State private var image: Image?
    
    let trashMob: TrashMob
    
    var body: some View {
        ZStack {
            image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        image = Image("trashyProperty")
        
    }
}



struct TrashMobBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobBackgroundImage(trashMob: TrashMob.testData[0])
    }
}

