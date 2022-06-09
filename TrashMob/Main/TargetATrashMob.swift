//
//  TargetATrashMob.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import SwiftUI
import MapKit

struct TargetATrashMob: View {
    @EnvironmentObject var vm: TrashMobViewModel
    @StateObject var mapvm = MapViewModel()
    @ObservedObject var cameraVM: CameraViewModel
    
    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @State var targetingUser = ""
    @State var beforePicture = URL(string: "https://knowpathology.com.au/wp-content/uploads/2018/07/Happy-Test-Screen-01.png")
    @State var targetDate: Date = Date()
    @State var trashMobState: String = "loading"
    @State var loves: Int = 1
    @State var attendees: [String] = []
    
    @Binding var needsDismissing: Bool
    
    var mapRegion = MKCoordinateRegion()
    
    //    var centerCoordinate: CLLocationCoordinate2D { get set }
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Spacer()
                    .frame(height: screenHeight * 0.005)
                
                ZStack {
                    MapView(viewModel: mapvm)
                        .frame(height: screenWidth)
                    Image(systemName: "plus")
                        .font(.title.weight(.bold))
                        .foregroundColor(Color(.systemPink))
                        .opacity(0.6)
                    Image(uiImage: UIImage(data: cameraVM.photo?.originalData ?? Data()) ?? UIImage())
                }
                
                Text("Place + on meetup location")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                Spacer()
                
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
                        
                        let mapRegion = mapvm.region
                        //                            let newTrashMob = TrashMob(targetingUser: targetingUser, beforePicture: beforePicture ?? URL(string: "https://knowpathology.com.au/wp-content/uploads/2018/07/happy-test-screen.jpg")!, targetDate: targetDate, latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude, lovers: [User.testData[0].id], attendees: [User.testData[0].id])
                        
                        
                        vm.addButtonPressed(targetingUser: targetingUser, beforePicture: cameraVM.photo ?? Photo(originalData: .init()), coordinate2D: CLLocationCoordinate2D(latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude))
                        
                        needsDismissing.toggle()
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
//            .edgesIgnoringSafeArea(.bottom)
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

//struct TargetATrashMob_Previews: PreviewProvider {
//    static var previews: some View {
//        TargetATrashMob()
//    }
//}
