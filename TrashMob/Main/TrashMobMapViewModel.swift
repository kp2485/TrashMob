//
//  TrashMobMapViewModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import MapKit

final class TrashMobMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private enum MapDetails {
        static let startingLocation = CLLocationCoordinate2D(latitude: 42.3314, longitude: -83.0458)
        static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        static let zoomedSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    }
    
// TODO: Initialize selectedTrashMob and make its location the regions defined below
//    var selectedTrashMob: TrashMob
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.zoomedSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            // Initialize locationManager as an optional with best location accuracy
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            // Set the delegate and force unwraps it
            locationManager!.delegate = self
        } else {
// FIX
            print ("Prompt user to change location settings")
        }
    }
    
    private func checkLocationAuthorization() {
        // Unwrap Optional
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls")
        case .denied:
            print("You have denied this app location permission. Go into settings to change the permission.")
        case .authorizedAlways, .authorizedWhenInUse:
            // TODO: change center to TM coord
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
        
}
