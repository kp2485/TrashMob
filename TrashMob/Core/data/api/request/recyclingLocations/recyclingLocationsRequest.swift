//
//  recyclingLocationsRequest.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/5/22.
//

import Foundation

// 1
enum RecyclingLocationsRequest: RequestProtocol {
  case getRecyclingLocationsWith(
    type: String, latitude: Double?, longitude: Double?)
  case getRecyclingLocationsBy(name: String, type: String)
  // 2
  var path: String {
    "/v2/recyclingLocations"
  }
  // 3
  var urlParams: [String: String?] {
    switch self {
    case let .getRecyclingLocationsWith(type, latitude, longitude):
      var params = ["type": String(type)]
      if let latitude = latitude {
        params["latitude"] = String(latitude)
      }

      if let longitude = longitude {
        params["longitude"] = String(longitude)
      }
      params["sort"] = "random"
      return params

    case let .getRecyclingLocationsBy(name, type):
      var params: [String: String] = [:]
      if !name.isEmpty {
        params["name"] = name
      }

        if let type: String? = type {
            params["type"] = String(type ?? "")
      }
      return params
    }
  }
  // 4
  var requestType: RequestType {
    .GET
  }
}
