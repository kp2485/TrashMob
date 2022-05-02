//
//  AddressFetcher.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import MapKit

final class AddressFetcher: ObservableObject {
  @Published var coordinates = MKCoordinateRegion(
    center: CLLocationCoordinate2D(
      latitude: 42.3314,
      longitude: -83.0458
    ),
    span: MKCoordinateSpan(
      latitudeDelta: 0.01,
      longitudeDelta: 0.01
    )
  )

  private let geocoder = CLGeocoder()

  @MainActor
  func search(by address: String) async {
    guard let placemarks = try? await geocoder.geocodeAddressString(address),
      let location = placemarks.first?.location else { return }
    coordinates.center = location.coordinate
  }
}
