//
//  trashMob.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/3/22.
//

import Foundation

struct TrashMob: Codable {
    var name: String?
    var creationDate: Date?
    var mobDate: Date?
    var status: String?
    var type: String?
    var suppliesNeeded: [String]?
    var suppliesVolunteered: [String]?
    var likes: Int?
    var comments: [String:String]?
}
