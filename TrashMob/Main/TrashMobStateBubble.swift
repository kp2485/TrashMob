//
//  TrashMobStateBubble.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/27/22.
//

import SwiftUI

struct TrashMobStateBubble: View {
    
    @EnvironmentObject var vm: TrashMobViewModel
    
    @State private var datePickerShown = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(alignment: .center)
                .foregroundColor(.primary)
                .colorInvert()
                .shadow(color: .black, radius: 2, x: 3, y: 3)
            
            
            if vm.selectedTrashMob!.trashMobState == "targeted" {
                HStack {
                    // TODO: User Profile Pic
                    VStack {
                        Text("\(vm.selectedTrashMob!.trashMobState.capitalizingFirstLetter()) by \(User.testData[0].name ?? "Anonymous")")
                            .font(.system(.title3))
                        Text("initiated on \(vm.selectedTrashMob!.targetDate.formatted(.dateTime.month().day()))")
                            .font(.caption)
                    }
                    
                }
                .foregroundColor(.primary)
                .padding(4)
                .opacity(0.9)
            } else if vm.selectedTrashMob!.trashMobState == "scheduling" {
                VStack {
                    Text("\(vm.selectedTrashMob!.trashMobState.capitalizingFirstLetter()) now!")
                        .font(.system(.title3))
                    Text("Pick a time here!")
                        .foregroundColor(.blue)
                        .font(.caption)
                        .onTapGesture {
                            datePickerShown = true
                        }
                        .popover(isPresented: $datePickerShown) {
                            DatePickerView()
                        }
                }
                .foregroundColor(.primary)
                .padding(4)
                .opacity(0.9)
                
            } else if vm.selectedTrashMob!.trashMobState == "scheduled" {
                VStack {
                    Text("\(vm.selectedTrashMob!.trashMobState.capitalizingFirstLetter())")
                        .font(.system(.title3))
                    Text("\(vm.selectedTrashMob!.scheduledDate!.formatted(.dateTime.month().day())) at \(vm.selectedTrashMob!.scheduledDate!.formatted(.dateTime.hour()))")
                        .font(.caption)
                }
                .foregroundColor(.primary)
                .padding(4)
                .opacity(0.9)
                
            } else if vm.selectedTrashMob!.trashMobState == "active" {
                VStack {
                    Text("Active!")
                        .font(.system(.title3))
                    Text("JOIN NOW!")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
                .foregroundColor(.primary)
                .padding(4)
                .opacity(0.9)
                
            } else if vm.selectedTrashMob!.trashMobState == "completed" {
                Text("🗑 ♻️ Completed 💃🏽 🕺🏼")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding(4)
                    .opacity(0.9)
                
            } else {
                Text("Loading ...")
                    .foregroundColor(.primary)
                    .padding(4)
                    .opacity(0.3)
                
            }
            
        }
    }
}

struct TrashMobStateBubble_Previews: PreviewProvider {
    static var previews: some View {
        TrashMobStateBubble()
    }
}
