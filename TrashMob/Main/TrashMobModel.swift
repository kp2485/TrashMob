//
//  TrashMobModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import Foundation
import CoreLocation

struct TrashMob: Identifiable, Codable, Hashable {
    
    var id: UUID = UUID()
    var targetingUser: String
    var beforePicture: URL
    var afterPicture: URL?
    var targetDate: Date
    var possibleDates: [Date]?
    var scheduledDate: Date?
    var startedDate: Date?
    var completedDate: Date?
    var archivedDate: Date?
    var trashMobState: String
    let latitude: Double
    let longitude: Double
    var lovers: Set<UUID>
    var attendees: Set<UUID>
    var comments: [UUID:String]?
    var referenceDate: Date {
        if trashMobState == "targeted" {
            return Date.now.addingTimeInterval(604800)
        } else if trashMobState == "scheduling" {
            return Date.now.addingTimeInterval(86400)
        } else if trashMobState == "scheduled" {
            return scheduledDate ?? Date()
        } else {
            return Date(timeIntervalSince1970: 1)
        }
    }
    var voteCount : Int {
        possibleDates?.count ?? 0
    }
    var loves: Int {
        lovers.count
    }
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var attending: Int {
        attendees.count
    }
    
    static let testData = [
        TrashMob(targetingUser: "Kyle", beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")!, targetDate: Date(), possibleDates: nil, trashMobState: "targeted", latitude: 42.3799, longitude: -83.1019, lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(targetingUser: "Dale", beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMtaMbty_ghAAEw_tYTw1HqJ5JrE-jRh_Ujw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976342), possibleDates: nil,  trashMobState: "scheduling", latitude: 42.3748, longitude: -83.1105, lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(targetingUser: "Jaelen", beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QREJ3CgtpHBmIg6J-nyrgDjGvx62jxrTRQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976453), possibleDates: nil, scheduledDate: Date(timeIntervalSince1970: 1652977453), trashMobState: "scheduled", latitude: 42.3836, longitude: -83.1118, lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[2].id]),
        TrashMob(targetingUser: "Ashlei", beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd9VR1KrMZKnt8Yw_PBXt4nzae1NY5nnU8sw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652972359), possibleDates: nil, trashMobState: "active", latitude: 42.3861, longitude: -82.9119, lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(targetingUser: "Angel", beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652978394), possibleDates: nil, trashMobState: "completed", latitude: 42.4240, longitude: -83.1140, lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id])
    ]
}
