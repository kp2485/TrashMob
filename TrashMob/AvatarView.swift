//
//  AvatarView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/18/22.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        ZStack {
            Circle().frame(width: 130, height: 130)
                .padding()
            Image("avatar")
                .frame(width: 120, height: 120)
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
