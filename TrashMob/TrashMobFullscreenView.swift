//
//  TrashMobFullscreenView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/16/22.
//

import SwiftUI

struct TrashMobFullscreenView: View {
    
    @State private var animateGradient = false
    
    enum TrashMobState {
        case loading
        case targeted
        case scheduling
        case scheduled
        case active
        case mobbed
        case archived
    }
    
    @State var trashMobStatus = "scheduled"
    @State var loves = 14
    //    @State var lovesNeeded = 25 - loves
    @State var loved = true
    @State var attending = 12
    @State var attended = false
    let distanceAway = "3.7 miles"
    
    
    @State var nowDate: Date = Date()
    let referenceDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
        ZStack {
            TrashMobBackgroundImage()
                .background()
            VStack {
                
                HStack {
                    VStack {
                        Spacer()
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(alignment: .center)
                                    .foregroundColor(.blue)
                                Text("\(trashMobStatus.capitalizingFirstLetter())")
                                    .font(.system(.title))
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                            .fixedSize()
                            .padding(.leading)
                            .offset(y: 15)
                            Spacer()
                        }
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(alignment: .center)
                                    .foregroundColor(.pink)
                                Text(countDownString(from: referenceDate))
                                    .onAppear(perform: {
                                        _ = self.timer
                                    })
                                    .font(.system(.body))
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                            .fixedSize()
                            .padding(.leading)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        if trashMobStatus == "scheduled" {
                            ZStack {
                                Circle()
                                    .frame(width: 95, height: 95)
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                                    .opacity(0.8)
                                    .shadow(radius: 20)
                                
                                LinearGradient(colors: [.gray, .white], startPoint: animateGradient ? .topLeading : .topTrailing, endPoint: animateGradient ? .bottomLeading : .topTrailing)
                                    .hueRotation(.degrees(0))
                                    .onAppear {
                                        withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                                            animateGradient.toggle()
                                        }
                                    }
                                    .mask {
                                        Image(systemName: "sparkles")
                                            .font(.system(size: 70))
                                            .padding(.trailing)
                                    }
                                    .frame(width: 115, height: 100)
                                    .opacity(0.66)
                                
                                Text("\(attending)")
                                    .padding(.trailing)
                                    .foregroundColor(.black)
                                    .font(.system(size: 37, weight: .medium, design: .rounded))
                                    .opacity(0.8)
                                    .shadow(color: .white, radius: 7)
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .frame(width: 100, height: 30, alignment: .bottomTrailing)
                                        .offset(x: -9, y: 33)
                                        .foregroundColor(.green)
                                        .opacity(0.85)
                                    if attended == false {
                                        Text("Help out!")
                                            .offset(x: -9, y: 33)
                                            .foregroundColor(.white)
                                    } else {
                                        Text("Attending!")
                                            .offset(x: -9, y: 33)
                                            .foregroundColor(.white)
                                    }
    //                                Text("\(lovesNeeded)")
                                }
                            }
                            .padding(.bottom)
                            .onTapGesture {
                                switch attended {
                                case true:
                                    attending -= 1
                                    attended = false
                                default:
                                    attending += 1
                                    attended = true
                                }
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
                                        .font(.system(size: 100))
                                        .padding(.trailing)
                                }
                                .frame(width: 115, height: 100)
                                .shadow(radius: 20)
                            
                            Text("\(loves)")
                                .padding(.trailing)
                                .font(.system(size: 37))
                                .foregroundColor(.white)
                                .offset(y: -5)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .frame(width: 100, height: 30, alignment: .bottomTrailing)
                                    .offset(x: -9, y: 31)
                                    .foregroundColor(.white)
                                    .opacity(0.85)
//                                Text("\(lovesNeeded)")
                            }
                            
                        }
                        .onTapGesture {
                            switch loved {
                            case true:
                                loves -= 1
                                loved = false
                            default:
                                loves += 1
                                loved = true
                            }
                        }
                    }
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
        return String(format: "%02dd:%02dh:%02dm:%02ds",
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
        TrashMobFullscreenView(referenceDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!)
    }
}

struct TrashMobFullscreenView_Previews2: PreviewProvider {
    
    static var previews: some View {
        TrashMobFullscreenView(referenceDate: Calendar.current.date(byAdding: .hour, value: 8, to: Date())!)
    }
}
