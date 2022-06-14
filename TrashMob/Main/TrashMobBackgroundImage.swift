//
//  TrashMobBackgroundImage.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import SwiftUI

struct TrashMobBackgroundImage: View {
    
    var beforePicture: URL?
    var afterPicture: URL?
    
    var body: some View {
        // TODO: Conditional statement for before/after display
        // TODO: Use image from TM URL, delete Image()
        Image("trashyProperty")
         .resizable()
         .aspectRatio(contentMode: .fill)
         .edgesIgnoringSafeArea(.all)
    }
}

struct TrashMobBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobBackgroundImage()
    }
}
