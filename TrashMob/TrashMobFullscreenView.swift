//
//  TrashMobFullscreenView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/16/22.
//

import SwiftUI

struct TrashMobFullscreenView: View {
    
    @State private var animateGradient = false
    
    var trashMobStatus = "targeted"
    @State var loves = 100
    
    
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
                        ZStack {
                            LinearGradient(colors: [.pink, .red], startPoint: animateGradient ? .bottomLeading : .topLeading, endPoint: animateGradient ? .topTrailing : .bottomTrailing)
                                .hueRotation(.degrees(0))
                                .onAppear {
                                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                                        animateGradient.toggle()
                                    }
                                }
                                .mask {
                                    
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 100))
                                    
                                    .padding(.trailing)
                                }
                            .frame(width: 110, height: 110)
                            
                            Text("\(loves)")
                                .padding(.trailing)
                                .font(.system(size: 37))
                                .foregroundColor(.white)
                                .offset(y: -5)
                        }
                        .onTapGesture {
                            loves += 1
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
        TrashMobFullscreenView(referenceDate: Date())
    }
}
