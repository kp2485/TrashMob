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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(alignment: .center)
                .foregroundColor(.white)
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
                }
                .padding(4)
            } else if trashMob.trashMobState == "scheduling" {
                VStack {
                    Text("\(trashMob.voteCount)")
                        .font(.system(.body))
                        .foregroundColor(.red)
                    
                    Text("Tap here to vote")
                        .foregroundColor(.blue)
                        .font(.caption2)
                }
                .padding(4)
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
                }
                .padding(4)
            } else if trashMob.trashMobState == "active" {
                VStack {
                    Text(countDownString(from: trashMob.referenceDate))
                        .onAppear(perform: {
                            _ = self.timer
                        })
                        .font(.system(.body))
                        .foregroundColor(.red)
                    
                    Text("until TrashMob disappears!")
                        .font(.caption2)
                }
                .padding(4)
            } else if trashMob.trashMobState == "mobbed" {
                VStack {
                    Text(countDownString(from: trashMob.referenceDate))
                        .onAppear(perform: {
                            _ = self.timer
                        })
                        .font(.system(.body))
                        .foregroundColor(.red)
                    
                    Text("until TrashMob disappears!")
                        .font(.caption2)
                }
                .padding(4)
            } else {
                Text("Loading ...")
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
