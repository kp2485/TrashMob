//
//  TrashMobBackgroundImage.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import SwiftUI

struct TrashMobBackgroundImage: View {
    
    var trashMob: TrashMob
    
    var body: some View {
        // TODO: Conditional statement for before/after display
        // TODO: Use image from TM URL, delete Image()
        
        Image("\(trashMob.trashMobState)")
        
         .resizable()
         .aspectRatio(contentMode: .fill)
         .edgesIgnoringSafeArea(.all)
    }
}

//struct TrashMobBackgroundImage_Previews: PreviewProvider {
//    static var previews: some View {
//        TrashMobBackgroundImage(trashMob: trashMob)
//    }
//}
