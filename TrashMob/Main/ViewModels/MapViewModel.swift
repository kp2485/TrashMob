//
//  MapViewModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import MapKit
import SwiftUI

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private enum MapDetails {
        static let startingLocation = CLLocationCoordinate2D(latitude: 42.3314, longitude: -83.0458)
        static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        static let zoomedSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    }
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
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
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                                 span: MapDetails.defaultSpan)
            }
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.checkLocationAuthorization()
        }
    }
    
    func checkIfLocationServicesIsEnabled(presentationContext: UIViewController?) {
            DispatchQueue.global(qos: .background).async {
                if CLLocationManager.locationServicesEnabled() {
                    // Initialize locationManager as an optional with best location accuracy
                    self.locationManager = CLLocationManager()
                    self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                    // Set the delegate and force unwraps it
                    self.locationManager!.delegate = self
                } else {
                    // Prompt user to change location settings on the main thread
                    DispatchQueue.main.async {
                        self.showLocationServicesAlert(in: presentationContext)
                    }
                }
            }
        }
        
    private func showLocationServicesAlert(in presentationContext: UIViewController?) {
            let alert = UIAlertController(
                title: "Location Services Disabled",
                message: "To use this app, please enable location services in Settings.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            // Present the alert using the provided presentation context
            if let context = presentationContext {
                if let windowScene = context.view.window?.windowScene {
                    // Use UIWindowScene.windows to get relevant windows
                    if let window = windowScene.windows.first {
                        window.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
}

