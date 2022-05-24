//
//  TargetATrashMob.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI
import MapKit

struct TargetATrashMob: View {
    
    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var trashMobs: [TrashMob]
    @State var targetingUser = ""
    @State var beforePicture = URL(string: "https://knowpathology.com.au/wp-content/uploads/2018/07/Happy-Test-Screen-01.png")
    @State var targetDate: Date = Date()
    @State var trashMobState: String = "loading"
    @State var loves: Int = 1
    @State var attendees: [String] = []
    
    var mapView: MapView
    var mapRegion = MKCoordinateRegion()
    
    init(trashMobs: Binding<[TrashMob]>) {
        _trashMobs = trashMobs
        mapView = MapView(trashMobs: trashMobs.wrappedValue)
    }
//    var centerCoordinate: CLLocationCoordinate2D { get set }
    
    var body: some View {
        
        VStack {
            NavigationView {
                VStack {
                    
                    Spacer()
                        .frame(height: screenHeight * 0.005)
                    
                    ZStack {
                        mapView
                            .frame(height: screenWidth)
                        Image(systemName: "plus")
                            .font(.title.weight(.bold))
                            .foregroundColor(Color(.systemPink))
                            .opacity(0.6)
                    }
                    
                    Text("Place + on meetup location")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.vertical, 1)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Form {
                        
                        TextField("Name of TrashMob", text: $targetingUser)
                        
                        
                        
                        
                    }
                    .onAppear(perform: {
                        UITableView.appearance().contentInset.top = -15
                    })
                    
                    HStack {
//                        Spacer()
//                        Button {
//                            presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image(systemName: "return")
//                        }
//                        .font(.title.weight(.bold))
//                        .foregroundColor(Color(.systemPink))
                        Spacer()
                        Button {
                            
                            let mapRegion = mapView.viewModel.region
                            let newTrashMob = TrashMob(targetingUser: targetingUser, beforePicture: beforePicture ?? URL(string: "https://knowpathology.com.au/wp-content/uploads/2018/07/happy-test-screen.jpg")!, targetDate: targetDate, trashMobState: trashMobState, latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude, loves: loves, lovers: [User.testData[0].id], attendees: [User.testData[0].id])
                            trashMobs.append(newTrashMob)
                            presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Confirm Trash Mob").fontWeight(.black)
                                }
                                .padding()
                                .background(.blue.opacity(0.90))
                                .foregroundColor(.white)
                                .font(.title2)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    .background()
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .opacity(0.90)
                .edgesIgnoringSafeArea(.bottom)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                            
                            Text ("Target A TrashMob")
                                .font(.largeTitle)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .frame(maxHeight: .infinity)
                        .background()
                        
                    }
                    //                    ToolbarItem(placement: .navigationBarLeading) {
                    //                        NavigationLink(destination: MySettings()) {
                    //                            Text ("My Settings")
                    //                        }
                    //                    }
                    //                    ToolbarItem(placement: .navigationBarTrailing) {
                    //                        NavigationLink(destination: MySettings()) {
                    //                            Text ("Target a TrashMob")
                    //                        }
                    //                    }
                }
            }
        }
    }
}

struct TargetATrashMob_Previews: PreviewProvider {
    static var previews: some View {
        TargetATrashMob(trashMobs: .constant(TrashMob.testData))
    }
}
