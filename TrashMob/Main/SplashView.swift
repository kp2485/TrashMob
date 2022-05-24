//
//  SplashView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    var body: some View {
        VStack {
            if self.isActive {
                // 3.
                ContentView()
                
            }
            else{
                Image("logo")
                    .resizable()
                    .renderingMode(.original)
                    .padding(.horizontal, 20.0)
                    .scaledToFit()
                
                Text("TrashMob")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
            }
        }.onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
