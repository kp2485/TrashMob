//
//  TrashMob.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/3/22.
//

import Foundation
import SwiftUI

struct TrashMob: Codable {
    var name: String?
    var createdBy: String?
    var creationDate: Int?
    var mobDate: Int?
    var latitude: Double?
    var longitude: Double?
    var status: String?
    var type: String?
//    var suppliesNeeded: [String]?
//    var suppliesVolunteered: [String]?
    var loves: Int?
    var comments: [String:String]?
    var attendees: [String]?
    var beforePicture: URL?
    var afterPicture: URL?
}
