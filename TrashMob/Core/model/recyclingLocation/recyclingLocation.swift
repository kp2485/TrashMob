//
//  RecyclingLocation.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/3/22.
//

import CoreLocation

struct RecyclingLocation: Codable {
    var curbside: Bool
    var description: String?
    var distance: Double
    var longitude: Double
    var latitude: Double
    var locationTypeID: Int
    var locationID: String
    var municipal: Bool
}
