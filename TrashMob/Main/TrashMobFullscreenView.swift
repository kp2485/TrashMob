//
//  TrashMobFullscreenView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/16/22.
//

import SwiftUI

struct TrashMobFullscreenView: View {
    
    @State private var animateGradient = false
    
    @State var trashMob: TrashMob
    
    @State var user : User
    
    @State var attended = false
    @State var loved = true
    
    //    init(trashMob: TrashMob, referenceDate: Date) {
    //        self.trashMob = trashMob
    //        self.referenceDate = referenceDate
    //
    //        _attending = State(initialValue: trashMob.attendees.count)
    //    }
    
    @State var nowDate: Date = Date()
    let referenceDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
        ZStack {
            TrashMobBackgroundImage(trashMob: trashMob)
                .background()
            VStack {
                
                // Top
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.screenWidth * 0.85, height: 60, alignment: .leading)
                    .foregroundColor(.gray)
                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 3, y: 3)
                    
                    
                    if trashMob.trashMobState == "targeted" {
                        VStack {
                            Text("\(trashMob.trashMobState.capitalizingFirstLetter()) by \(User.testData[0].name ?? "Anonymous")")
                                .font(.system(.title3))
                            Text("initiated on \(trashMob.targetDate.formatted(.dateTime.month().day()))")
                                .font(.caption)
                        }
                        
                    } else if trashMob.trashMobState == "scheduling" {
                        VStack {
                            Text("\(trashMob.trashMobState.capitalizingFirstLetter()) now!")
                                .font(.system(.title3))
                            Text("Pick a time here!")
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                    } else if trashMob.trashMobState == "scheduled" {
                        VStack {
                            Text("\(trashMob.trashMobState.capitalizingFirstLetter())")
                                .font(.system(.title3))
                            Text("\(trashMob.scheduledDate.formatted(.dateTime.month().day())) at \(trashMob.scheduledDate.formatted(.dateTime.hour()))")
                                .font(.caption)
                        }
                    } else if trashMob.trashMobState == "active" {
                        VStack {
                            Text("Active!")
                                .font(.system(.title3))
                            Text("JOIN NOW!")
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                    } else if trashMob.trashMobState == "mobbed" {
                        Text("🗑 ♻️ Mobbed 💃🏽 🕺🏼")
                    } else {
                        Text("Loading ...")
                            .opacity(0.3)
                    }
                    
                    
                    
                    
                    
                }
                .foregroundColor(.black)
                .padding(7)
                .fixedSize()
                .offset(y: 15)
                
                // Countdown Bubble
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                    
                    
                    if trashMob.trashMobState == "targeted" {
                        VStack {
                            Text(countDownString(from: referenceDate))
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
                            Text(countDownString(from: referenceDate))
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
                            Text(countDownString(from: referenceDate))
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
                            Text(countDownString(from: referenceDate))
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
                .fixedSize()
                
                
                
                
                // Middle
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        
                        if trashMob.trashMobState == "scheduled" {
                            ZStack {
                                Circle()
                                    .frame(width: 65, height: 65)
                                    .foregroundColor(.white)
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
                                        Image(systemName: "sparkles")
                                            .font(.system(size: 50))
                                            .padding(.trailing)
                                    }
                                    .frame(width: 80, height: 65)
                                    .opacity(1.0)
                                
                                Text("\(trashMob.attending)")
                                    .padding(.trailing)
                                    .foregroundColor(.black)
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
                                    if attended == false {
                                        Text("Help out!")
                                            .offset(x: -9, y: 24)
                                            .foregroundColor(.white)
                                    } else {
                                        Text("Attending!")
                                            .offset(x: -9, y: 24)
                                            .foregroundColor(.white)
                                    }
                                    //                                Text("\(lovesNeeded)")
                                }
                                .fixedSize()
                            }
                            
                            .padding(.bottom)
                            .onTapGesture {
                                trashMob.attendees.insert(User.testData[0].id)
                            }
                        }
                        
                        
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
                                    Text("\(5 - trashMob.loves) needed!")
                                        .offset(x: -9, y: 24)
                                        .foregroundColor(.blue)
                                } else {
                                    Text("Liked!")
                                        .offset(x: -9, y: 24)
                                        .foregroundColor(.blue)
                                }
                                //                                Text("\(lovesNeeded)")
                            }
                            
                            
                        }
                        .onTapGesture {
                            trashMob.lovers.insert(User.testData[0].id)
                        }
                        
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
                            Text("\(TrashMob.testData[0].comments?.count ?? 0)")
                                .foregroundColor(.white)
                                .offset(x: 19, y: -25)
                        }
                        .padding(.top)
                        Spacer()
                    }
                    
                }
                // Bottom
                HStack {
                    
                    ZStack {
                        VStack {
                            MapView(trashMobs: [trashMob.self])
                                .frame(width: 150, height: 150)
                                .mask(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .black, radius: 2, x: 3, y: 3)
                            Spacer()
                        }
                        
                        
                        VStack {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).frame(height: 30)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                                Text("3.7 miles away")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .padding(4)
                                    .opacity(0.6)
                            }
                            .fixedSize()
                            
                        }
                        
                    }
                    .padding(.leading)
                    .frame(width: 150, height: 160)
                    
                    Spacer()
                    
                }
            }
            .frame(width: UIScreen.screenWidth)
        }
    }
    
    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02dd %02dh %02dm %02ds",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

struct TrashMobFullscreenView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        TrashMobFullscreenView(trashMob: TrashMob.testData[2], user: User.testData[0], referenceDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!)
    }
}

struct TrashMobFullscreenView_Previews2: PreviewProvider {
    
    static var previews: some View {
        TrashMobFullscreenView(trashMob: TrashMob.testData[0], user: User.testData[0], referenceDate: Calendar.current.date(byAdding: .hour, value: 8, to: Date())!)
        
    }
}


