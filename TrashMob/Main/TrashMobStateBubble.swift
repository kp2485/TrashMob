//
//  TrashMobStateBubble.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/27/22.
//

import SwiftUI

struct TrashMobStateBubble: View {
    
    var trashMob: TrashMob
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(alignment: .center)
                .foregroundColor(.primary)
                .colorInvert()
                .shadow(color: .black, radius: 2, x: 3, y: 3)
            
            
            if trashMob.trashMobState == "targeted" {
                VStack {
                    Text("\(trashMob.trashMobState.capitalizingFirstLetter()) by \(User.testData[0].name ?? "Anonymous")")
                        .font(.system(.title3))
                    Text("initiated on \(trashMob.targetDate.formatted(.dateTime.month().day()))")
                        .font(.caption)
                }
                .foregroundColor(.primary)
                .padding(4)
            } else if trashMob.trashMobState == "scheduling" {
                VStack {
                    Text("\(trashMob.trashMobState.capitalizingFirstLetter()) now!")
                        .font(.system(.title3))
                    Text("Pick a time here!")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
                .foregroundColor(.primary)

            } else if trashMob.trashMobState == "scheduled" {
                VStack {
                    Text("\(trashMob.trashMobState.capitalizingFirstLetter())")
                        .font(.system(.title3))
                    Text("\(trashMob.scheduledDate!.formatted(.dateTime.month().day())) at \(trashMob.scheduledDate!.formatted(.dateTime.hour()))")
                        .font(.caption)
                }
                .foregroundColor(.primary)

            } else if trashMob.trashMobState == "active" {
                VStack {
                    Text("Active!")
                        .font(.system(.title3))
                    Text("JOIN NOW!")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
                .foregroundColor(.primary)

            } else if trashMob.trashMobState == "mobbed" {
                Text("🗑 ♻️ Mobbed 💃🏽 🕺🏼")
                    .foregroundColor(.primary)

            } else {
                Text("Loading ...")
                    .foregroundColor(.primary)

                    .opacity(0.3)

            }
            
            
            
            
            
        }
    }
}

struct TrashMobStateBubble_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobStateBubble(trashMob: TrashMob.testData[0])
    }
}
