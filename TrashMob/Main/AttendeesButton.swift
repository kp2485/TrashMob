//
//  AttendeesButton.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/9/22.
//

import SwiftUI

struct AttendeesButton: View {
    
    var trashMob: TrashMob
    
    @State private var animateGradient = false
    
    var body: some View {
        if trashMob.trashMobState == "scheduled" {
            ZStack {
                Circle()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding(.trailing)
                    .opacity(0.8)
                    .shadow(radius: 3)
                LinearGradient(colors: [.white, .gray, .white], startPoint: animateGradient ? .topLeading : .topTrailing, endPoint: animateGradient ? .bottomLeading : .topTrailing)
                    .hueRotation(.degrees(0))
                    .onAppear {
                        withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                    .mask {
                        Image(systemName: "hands.sparkles.fill")
                            .font(.system(size: 45))
                            .padding(.trailing)
                    }
                    .frame(width: 80, height: 65)
                    .opacity(1.0)
                
                Text("\(trashMob.attending)")
                    .padding(.trailing)
                    .foregroundColor(.primary)
                    .font(.system(size: 33, weight: .regular, design: .rounded))
                    .opacity(0.8)
                    .shadow(color: .white, radius: 7)
                    .offset(y: -3)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(width: 100, height: 25, alignment: .bottomTrailing)
                        .offset(x: -9, y: 24)
                        .foregroundColor(.green)
                        .opacity(0.85)
                    // TODO: Change to current user
                    if trashMob.attendees.contains(User.testData[0].id) {
                        Text("Attending!")
                            .offset(x: -9, y: 24)
                            .foregroundColor(.white)
                    } else {
                        Text("Help out!")
                            .offset(x: -9, y: 24)
                            .foregroundColor(.white)
                    }
                }
                .fixedSize()
            }
            .padding(.bottom)
        }
    }
}

struct AttendeesButton_Previews: PreviewProvider {
    static var previews: some View {
        AttendeesButton(trashMob: TrashMob.testData[2])
    }
}
