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
                            .font(.title)
                            .foregroundColor(.red)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.caption)
                            .foregroundColor(.red)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Image(systemName: "target")
                        .foregroundColor(.white)
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            }                 else if trashMobState == "scheduling" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("📆")
                        .font(.caption)
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            } else if trashMobState == "scheduled" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.title)
                            .foregroundColor(.yellow)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Text("⏳")
                        .font(.caption)
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            } else if trashMobState == "active" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.title)
                            .foregroundColor(.green)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.caption)
                            .foregroundColor(.green)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Image(systemName: "hands.sparkles.fill")
                    //                            .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -7)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                }
            } else if trashMobState == "completed" {
                ZStack {
                    VStack {
                        Image(systemName: "circle.fill")
                            .font(.title)
                            .foregroundColor(.cyan)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.caption)
                            .foregroundColor(.cyan)
                            .offset(x: 0, y: -6)
                    }
                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                    Image(systemName: "sparkles")
                    //                            .font(.caption)
                        .foregroundColor(.white)
                        .offset(y: -6)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                    
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
