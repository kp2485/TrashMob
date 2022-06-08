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
    
    //TODO: remove and resolve
    
    var body: some View {
        
        ZStack {
            TrashMobBackgroundImage(trashMob: trashMob)
                .background()
            VStack {
                
                // Top
                
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: UIScreen.screenWidth * 0.85, height: 60, alignment: .leading)
//                    .foregroundColor(.gray)
//                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                
                TrashMobStateBubble(trashMob: trashMob)
                .foregroundColor(.black)
                .fixedSize()
                
                
                // Countdown Bubble
                
                CountdownBubble(trashMob: trashMob)
                .fixedSize()
                .offset(y: -8)
                
                
                
                
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
                                    if trashMob.attendees.contains(User.testData[0].id) {
                                        Text("Attending!")
                                            .offset(x: -9, y: 24)
                                            .foregroundColor(.white)
                                    } else {
                                        Text("Help out!")
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
                                    Text("Loved!")
                                        .offset(x: -9, y: 24)
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            
                        }
                        .onTapGesture {
                            
                            switch trashMob.lovers.contains(User.testData[0].id) {
                            
                            case true:
                                trashMob.lovers.remove(User.testData[0].id)
                            default:
                                trashMob.lovers.insert(User.testData[0].id)
                            }
                            
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
                            MapView()
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
        TrashMobFullscreenView(trashMob: TrashMob.testData[2], user: User.testData[0])
    }
}

struct TrashMobFullscreenView_Previews2: PreviewProvider {
    
    static var previews: some View {
        TrashMobFullscreenView(trashMob: TrashMob.testData[0], user: User.testData[0])
        
    }
}


