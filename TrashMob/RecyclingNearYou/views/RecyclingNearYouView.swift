//
//  RecyclingNearYouView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct RecyclingLocationsNearYouView: View {
  @State var recyclingLocations: [RecyclingLocation] = []
  @State var isLoading = true
  private let requestManager = RequestManager()

  var body: some View {
    NavigationView {
      List {
        ForEach(recyclingLocations) { recyclingLocation in
          RecyclingLocationRow(recyclingLocation: recyclingLocation)
        }
      }
      .task {
        await fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Locations near you")
      .overlay {
        if isLoading {
          ProgressView("Finding locations near you...")
        }
      }
    }.navigationViewStyle(StackNavigationViewStyle())
  }

  func fetchAnimals() async {
    do {
      let recyclingLocationsContainer: RecyclingLocationsContainer = try await requestManager.perform(RecyclingLocationsRequest.getRecyclingLocationsWith(
        type: "1",
        latitude: nil,
        longitude: nil))
      let recyclingLocations = recyclingLocationsContainer.recyclingLocations
      self.recyclingLocations = recyclingLocations
      await stopLoading()
    } catch {
    }
  }

  @MainActor
  func stopLoading() async {
    isLoading = false
  }
}

struct RecyclingLocationsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    RecyclingLocationsNearYouView(recyclingLocations: RecyclingLocation.mock, isLoading: false)
  }
}
