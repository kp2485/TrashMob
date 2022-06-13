//
//  LovesButton.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import SwiftUI

struct LovesButton: View {
    
    var trashMob: TrashMob
    
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .red, .yellow], startPoint: animateGradient ? .bottomLeading : .topTrailing, endPoint: animateGradient ? .topLeading : .topTrailing)
                .hueRotation(.degrees(0))
                .onAppear {
                    withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                .mask {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 65))
                        .padding(.trailing)
                }
                .frame(width: 80, height: 65)
                .shadow(radius: 3)
            
            Text("\(trashMob.loves)")
                .padding(.trailing)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .offset(y: -4)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .frame(width: 85, height: 25, alignment: .bottomTrailing)
                    .offset(x: -9, y: 24)
                    .foregroundColor(.white)
                    .opacity(0.85)
                if trashMob.loves < 5 {
                    Text("\(5 - trashMob.loves) more!")
                        .offset(x: -9, y: 24)
                        .foregroundColor(.blue)
                } else {
                    Text("Loved!")
                        .offset(x: -9, y: 24)
                        .foregroundColor(.blue)
                }
            }
            
            
        }
    }
}

struct LovesButton_Previews: PreviewProvider {
    static var previews: some View {
        LovesButton(trashMob: TrashMob.testData[1])
    }
}
