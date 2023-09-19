//
//  TrashMobMapAnnotation.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/6/22.
//

import SwiftUI

struct TrashMobMapAnnotation: View {
    var trashMobState: String
    
    var body: some View {
        Group {
            if trashMobState == "targeted" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("🎯")
                        .font(.system(size: 20))
                        .offset(y: -9)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            }                 else if trashMobState == "scheduling" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.yellow)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.yellow)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("📆")
                        .font(.system(size: 16))
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            } else if trashMobState == "scheduled" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.green)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("✋")
                        .font(.system(size: 20))
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            } else if trashMobState == "active" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.purple)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.purple)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("🚮")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                    
                }
            } else if trashMobState == "completed" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.blue)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("✨")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .offset(y: -6)
                        .shadow(color: .black, radius: 1, x: 3, y: 1)
                    
                }
            }
        }
    }
}
struct TrashMobMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobMapAnnotation(trashMobState: "scheduled")
    }
}
