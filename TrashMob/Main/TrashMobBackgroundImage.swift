//
//  TrashMobBackgroundImage.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/16/22.
//

import SwiftUI

struct TrashMobBackgroundImage: View {
//    @State private var url: URL
    
    let trashMob: TrashMob
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            }
               
            
        }
//        .onAppear(perform: loadImage)
    }
    
//    func loadImage() {
//        image = Image("trashyProperty")
//        image = AsyncImage(url: trashMob.beforePicture)
//    }
}



struct TrashMobBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobBackgroundImage(trashMob: TrashMob.testData[0])
    }
}

