//
//  RecyclingDetailsView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct RecyclingDetailsView: View {
    var body: some View {
        Text("TODO: Animal Details")
    }
}

struct RecyclingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecyclingDetailsView()
                .previewLayout(.sizeThatFits)
                .previewDisplayName("iPhone SE (2nd generation)")
        }
        NavigationView {
            RecyclingDetailsView()
                .previewDevice("iPhone 12 Pro")
                .previewDisplayName("iPhone 12 Pro")
        }
    }
}
