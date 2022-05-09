//
//  FrameView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/28/22.
//

import SwiftUI

struct FrameView: View {
    
    var image: CGImage?
    private let label = Text("Camera feed")
    
    var body: some View {
        // Conditionally unwrap the optional image
        if let image = image {
            // find size of the view
            GeometryReader { geometry in
                // Create image from CGImage, fit to view
                Image(image, scale: 1.0, orientation: .upMirrored, label: label)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center)
                    .clipped()
            }
        } else {
            // Return black view if image property is nil
            Color.black
        }
        
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
