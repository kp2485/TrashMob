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
    @EnvironmentObject var TMviewModel: TrashMobMapViewModel
    
    @State var user : User
    
    var body: some View {
        
        ZStack {
            if vm.selectedTrashMob != nil {
                if vm.selectedTrashMob!.trashMobState == "completed" || vm.selectedTrashMob!.trashMobState == "archived" {
                    TrashMobBackgroundImage(beforePicture: vm.selectedTrashMob!.beforePicture, afterPicture: vm.selectedTrashMob!.afterPicture)
                        .background()
                } else {
                    TrashMobBackgroundImage(beforePicture: vm.selectedTrashMob!.beforePicture)
                        .background()
                }
                
                VStack {
                    
                    // Top
                    
                    // TODO: Add advertisement
                    //                RoundedRectangle(cornerRadius: 10)
                    //                    .frame(width: UIScreen.screenWidth * 0.85, height: 60, alignment: .leading)
                    //                    .foregroundColor(.gray)
                    //                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                    
                    TrashMobStateBubble()
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
                                    switch vm.selectedTrashMob!.lovers.contains(User.testData[0].id) {
                                    case true:
                                    vm.selectedTrashMob!.lovers.remove(User.testData[0].id)
                                    default:
                                    vm.selectedTrashMob!.attendees.insert(User.testData[0].id)
                                    }
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
                            
                            CommentsButton(trashMob: vm.selectedTrashMob!)
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
                                TrashMobMapView(TMviewModel: TMviewModel)
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
                                    if let location = TMviewModel.locationManager?.location {
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


