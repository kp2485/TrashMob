//
//  TrashMobModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import Foundation
import CoreLocation
import CloudKit

struct TrashMob: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var targetingUser: String
    var beforePicture: URL?
    var afterPicture: URL?
    var targetDate: Date
    var schedulingDate: Date?
    var possibleDates: [Date]?
    var scheduledDate: Date?
    var isActive: Bool?
    var reported: Bool?
    var startedDate: Date?
    var completedDate: Date?
    var archivedDate: Date?
    let coordinate: CLLocation
    var lovers: Set<UUID> = Set<UUID>()
    var loves: Int {
        lovers.count
    }
    var schedulingState: Bool {
        if loves > 4 && schedulingDate != nil && scheduledDate == nil {
            return true
        } else {
            return false
        }
    }
    var attendees: Set<UUID> = Set<UUID>()
    var comments: [UUID:String]?
    var referenceDate: Date {
        if trashMobState == "targeted" {
            return targetDate.addingTimeInterval(604800)
        } else if trashMobState == "scheduling" {
            return schedulingDate?.addingTimeInterval(86400) ?? Date.now.addingTimeInterval(86400)
        } else if trashMobState == "scheduled" {
            return scheduledDate ?? Date()
        } else {
            return Date(timeIntervalSince1970: 1)
        }
    }
    var voteCount : Int {
        possibleDates?.count ?? 0
    }
    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude)
    }
    var attending: Int {
        attendees.count
    }
    var trashMobState: String {
        if schedulingState == true {
            return "scheduling"
        } else if schedulingDate?.addingTimeInterval(86400) ?? Date.now.addingTimeInterval(-10) > Date.now {
            return "scheduled"
        } else if scheduledDate ?? Date.now.addingTimeInterval(-10) > Date.now && isActive == true {
            return "active"
        } else if isActive == true && afterPicture != nil {
            return "completed"
        } else if completedDate?.addingTimeInterval(604800*2) ?? Date.now.addingTimeInterval(-10) > Date.now {
            return "archived"
        } else if reported == true {
            return "reported"
        } else {
            return "targeted"
        }
    }
    
    func pickDate() {
        
    }
    
    static let testData = [
        TrashMob(targetingUser: "Kyle", beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")!, targetDate: Date(), possibleDates: nil, coordinate: CLLocation(latitude: 42.3799, longitude: -83.1019), lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(targetingUser: "Dale", beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMtaMbty_ghAAEw_tYTw1HqJ5JrE-jRh_Ujw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976342), possibleDates: nil, coordinate: CLLocation(latitude: 42.3748, longitude: -83.1105), lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(targetingUser: "Jaelen", beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QREJ3CgtpHBmIg6J-nyrgDjGvx62jxrTRQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976453), possibleDates: nil, scheduledDate: Date(timeIntervalSince1970: 1652977453), coordinate: CLLocation(latitude: 42.3836, longitude: -83.1118), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[2].id]),
        TrashMob(targetingUser: "Ashlei", beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd9VR1KrMZKnt8Yw_PBXt4nzae1NY5nnU8sw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652972359), possibleDates: nil, coordinate: CLLocation(latitude: 42.3861, longitude: -82.9119), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(targetingUser: "Angel", beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652978394), possibleDates: nil, coordinate: CLLocation(latitude: 42.4240, longitude: -83.1140), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id])
    ]
}
