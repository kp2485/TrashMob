//
//  CommentsButton.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import SwiftUI

struct CommentsButton: View {
    
    var trashMob: TrashMob
    
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .frame(width: 40, height: 30, alignment: .center)
                .offset(x: -8, y: -5)
            LinearGradient(colors: [.blue, .cyan], startPoint: animateGradient ? .bottomLeading : .topTrailing, endPoint: animateGradient ? .topLeading : .topTrailing)
                .hueRotation(.degrees(0))
                .onAppear {
                    withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                .mask {
                    Image(systemName: "text.bubble.fill")
                        .font(.system(size: 60))
                        .padding(.trailing)
                }
                .frame(width: 80, height: 65)
                .shadow(radius: 01)
            Circle()
                .foregroundColor(.pink)
            
                .frame(width: 25, height: 25, alignment: .trailing)
                .padding()
                .offset(x: 19, y: -25)
            Text("\(trashMob.comments?.count ?? 0)")
                .foregroundColor(.white)
                .offset(x: 19, y: -25)
        }
        .padding(.top)
    }
}

struct CommentsButton_Previews: PreviewProvider {
    static var previews: some View {
        CommentsButton(trashMob: TrashMob.testData[2])
    }
}
