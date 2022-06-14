//
//  CountdownBubble.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/27/22.
//

import SwiftUI

struct CountdownBubble: View {
    
    var trashMob: TrashMob
    
    @State var nowDate: Date = Date()
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var upTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: nowDate,
                            to: trashMob.referenceDate)
        return String(format: "%02dd %02dh %02dm %02ds",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    
    func countUpString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.hour, .minute, .second],
                            from: trashMob.referenceDate,
                            to: nowDate)
        return String(format: "%02dh %02dm %02ds",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(alignment: .center)
                .foregroundColor(.primary)
                .colorInvert()
                .shadow(color: .black, radius: 3, x: 3, y: 3)
            
            
            if trashMob.trashMobState == "targeted" {
                VStack {
                    Text(countDownString(from: trashMob.referenceDate))
                        .onAppear(perform: {
                            _ = self.timer
                        })
                        .font(.system(.body))
                        .foregroundColor(.red)
                    
                    Text("until TrashMob disappears!")
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
                .padding(5)
            } else if trashMob.trashMobState == "scheduling" {
                VStack {
                    Text("\(trashMob.voteCount) votes received")
                        .font(.system(.body))
                        .foregroundColor(.green)
                    
                    Text(countDownString(from: trashMob.referenceDate))
                        .onAppear(perform: {
                            _ = self.timer
                        })
                        .font(.system(.body))
                        .foregroundColor(.red)
                }
                .padding(5)
            } else if trashMob.trashMobState == "scheduled" {
                VStack {
                    Text(countDownString(from: trashMob.referenceDate))
                        .onAppear(perform: {
                            _ = self.timer
                        })
                        .font(.system(.body))
                        .foregroundColor(.red)
                    
                    Text("until TrashMob starts!")
                        .font(.caption2)
                        .foregroundColor(.primary)
                }
                .padding(5)
            } else if trashMob.trashMobState == "active" {
                VStack {
                    Text(countDownString(from: trashMob.referenceDate))
                        .onAppear(perform: {
                            _ = self.upTimer
                        })
                        .font(.system(.body))
                        .foregroundColor(.green)
                }
                .padding(5)
            } else if trashMob.trashMobState == "completed" {
                VStack {
                    Text("Show your thanks to \(User.testData[4].name ?? "the volunteers!")")
                        .font(.system(.body))
                        .foregroundColor(.red)
                    if User.testData[4].name != nil || User.testData[4].name != "" {
                        Text("and all the volunteers!")
                    }
                }
                .padding(5)
            } else {
                Text("Loading ...")
                    .foregroundColor(.primary)
                    .opacity(0.3)
            }
            
        }
    }
}

struct CountdownBubble_Previews: PreviewProvider {
    static var previews: some View {
        CountdownBubble(trashMob: TrashMob.testData[0])
    }
}
