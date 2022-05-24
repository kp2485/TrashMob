//
//  MapViewModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D (latitude: 42.3314, longitude: -83.0458)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    static let zoomedSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
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
            // update region, force unwrapped optional
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

