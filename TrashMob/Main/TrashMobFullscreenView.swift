//
//  TrashMobFullscreenView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/16/22.
//

import SwiftUI

struct TrashMobFullscreenView: View {
    
    @State private var animateGradient = false
    @State private var commentsShown = false
    @State private var confirmationShown = false
    
    @EnvironmentObject var vm: TrashMobViewModel
    @EnvironmentObject var viewModel: MapViewModel
    
    @State var user : User
    
    var body: some View {
        
        ZStack {
            if vm.selectedTrashMob != nil {
                TrashMobBackgroundImage(trashMob: vm.selectedTrashMob!)
                    .background()
                VStack {
                    
                    // Top
                    
                    // TODO: Add advertisement
                    //                RoundedRectangle(cornerRadius: 10)
                    //                    .frame(width: UIScreen.screenWidth * 0.85, height: 60, alignment: .leading)
                    //                    .foregroundColor(.gray)
                    //                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                    
                    TrashMobStateBubble(trashMob: vm.selectedTrashMob!)
                        .foregroundColor(.black)
                        .fixedSize()
                    
                    
                    // Countdown Bubble
                    
                    CountdownBubble(trashMob: vm.selectedTrashMob!)
                        .fixedSize()
                        .offset(y: -8)
                    
                    
                    
                    
                    // Middle
                    HStack {
                        
                        VStack {
                            Spacer()
                            Text("⚠️").font(.title3)
                            Text("Report")
                                .font(.caption)
                        }
                        .onTapGesture {
                            confirmationShown = true
                        }
                        .confirmationDialog(
                            "Report this TrashMob due to:",
                            isPresented: $confirmationShown
                        ) {
                            // TODO: $vm.selectedTrashMob.reported = true , move reported TM to new CK record type "reportedMobs"
                            Button("Offensive content", role: .destructive) {  }
                            Button("Inappropriate location", role: .destructive) {  }
                            Button("Cancel", role: .cancel) {}
                            
                        }
                        .padding()
                        
                        
                        Spacer()
                        VStack {
                            Spacer()
                            
                            if vm.selectedTrashMob!.trashMobState == "scheduled" {
                                AttendeesButton(trashMob: vm.selectedTrashMob!)
                                // TODO: CK Update the TM, use current user
                                .onTapGesture {
                                    vm.selectedTrashMob!.attendees.insert(User.testData[0].id)
                                }
                            }
                            
                            
                            LovesButton(trashMob: vm.selectedTrashMob!)
                            .onTapGesture {
                                switch vm.selectedTrashMob!.lovers.contains(User.testData[0].id) {
                                case true:
                                    vm.selectedTrashMob!.lovers.remove(User.testData[0].id)
                                default:
                                    vm.selectedTrashMob!.lovers.insert(User.testData[0].id)
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
                                Text("\(vm.selectedTrashMob!.comments?.count ?? 0)")
                                    .foregroundColor(.white)
                                    .offset(x: 19, y: -25)
                            }
                            .padding(.top)
                            .onTapGesture {
                                commentsShown = true
                            }
                            .popover(isPresented: $commentsShown) {
                                CommentView()
                            }
                            Spacer()
                        }
                        
                    }
                    // Bottom
                    HStack {
                        
                        ZStack {
                            VStack {
                                // TODO: Change to MapView centered on TM (with animation noting selected TM) with no links on pins
                                MapView(viewModel: viewModel)
                                    .frame(width: 150, height: 150)
                                    .mask(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: .black, radius: 2, x: 3, y: 3)
                                Spacer()
                            }
                            
                            
                            VStack {
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).frame(height: 30)
                                        .foregroundColor(.primary)
                                        .colorInvert()
                                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                                    if let location = viewModel.locationManager?.location {
                                        Text(vm.selectedTrashMob!.distance(to: location))
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding(4)
                                            .opacity(0.7)
                                    } else {
                                        Text("Enable 📍")
                                    }
                                    
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
        TrashMobFullscreenView(user: User.testData[0])
    }
}

struct TrashMobFullscreenView_Previews2: PreviewProvider {
    
    static var previews: some View {
        TrashMobFullscreenView(user: User.testData[0])
        
    }
}


