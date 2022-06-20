//
//  TrashMobModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import Foundation
import CoreLocation
import CloudKit
import MapKit

struct TrashMob: Identifiable, Hashable {
    
    var id: CKRecord.ID
    var targetingUser: CKRecord.ID
    var beforePicture: URL?
    var afterPicture: URL?
    var targetDate: Date
    var schedulingDate: Date?
    var possibleDates: [Date]?
    var scheduledDate: Date?
    var isActive: Bool = false
    var reported: Bool?
    var startedDate: Date?
    var completedDate: Date?
    var duration: TimeInterval {
        3600.0
    }
    let coordinate: CLLocation
    var lovers: Set<CKRecord.ID> = Set<CKRecord.ID>()
    var loves: Int {
        lovers.count
    }
    var attendees: Set<CKRecord.ID> = Set<CKRecord.ID>()
    
    var voteCount : Int {
        possibleDates?.count ?? 0
    }
    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude)
    }
    var attending: Int {
        attendees.count
    }
    var endSchedulingDate: Date? {
        schedulingDate?.addingTimeInterval(86400)
    }
    var endSchedulingWindow: Date? {
        endSchedulingDate?.addingTimeInterval(604800)
    }
    var archivedDate: Date? {
        completedDate?.addingTimeInterval(604800*2)
    }
    var referenceDate: Date {
        if trashMobState == "targeted" {
            return targetDate.addingTimeInterval(604800)
        } else if trashMobState == "scheduling" {
            return endSchedulingDate ?? Date.now.addingTimeInterval(86400)
        } else if trashMobState == "scheduled" {
            return scheduledDate ?? Date()
        } else if trashMobState == "active" {
            return scheduledDate ?? Date()
        } else {
            return Date.now
        }
    }
    var trashMobState: String {
        if schedulingDate == nil || loves <= 4 {
            return "targeted"
        }
        if let endSchedulingDate = endSchedulingDate,
           Date.now < endSchedulingDate,
            loves > 4 {
            return "scheduling"
        } else if scheduledDate != nil && afterPicture == nil && !isActive {
            return "scheduled"
        } else if isActive {
            return "active"
        } else if !isActive && afterPicture != nil {
            return "completed"
        } else if let archivedDate = archivedDate,
                  Date.now > archivedDate  {
            return "archived"
        } else if reported == true {
            return "reported"
        } else {
            return "loading"
        }
    }
    var record: CKRecord?
    var comments: [UUID: String]?
//    TODO: How do I conform to data type and comments inside each TM?
//    struct Comment {
//        var id: UUID = UUID()
//        var userID: UUID
//        var comment: String = ""
//        var date = Date()
//    }
//    var comments: [Comment]?
    
    func pickDate() {
        
    }
    func distance(to userLocation: CLLocation) -> String {
        let distance = userLocation.distance(from: coordinate)
        let mdf = MKDistanceFormatter()
        mdf.units = .imperial
        return mdf.string(for: distance) ?? ""
    }
    
    static let testData = [
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, afterPicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652978394), schedulingDate: Date.now.addingTimeInterval(-1000000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(-100000), isActive: false, coordinate: CLLocation(latitude: 42.33225, longitude: -83.04532), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")!, targetDate: Date(), possibleDates: nil, coordinate: CLLocation(latitude: 42.33184, longitude: -83.05346), lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QREJ3CgtpHBmIg6J-nyrgDjGvx62jxrTRQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976453), schedulingDate: Date.now.addingTimeInterval(-120000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(240000), coordinate: CLLocation(latitude: 42.33593, longitude: -83.04269), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[2].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd9VR1KrMZKnt8Yw_PBXt4nzae1NY5nnU8sw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652972359), schedulingDate: Date.now.addingTimeInterval(-500000), possibleDates: nil, scheduledDate: Date.now, isActive: true, coordinate: CLLocation(latitude: 42.33618, longitude: -83.05295), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMtaMbty_ghAAEw_tYTw1HqJ5JrE-jRh_Ujw&usqp=CAU")!, targetDate: Date.now.addingTimeInterval(-100000), schedulingDate: Date.now.addingTimeInterval(-12000), possibleDates: nil, coordinate: CLLocation(latitude: 42.33142, longitude: -83.03471), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMtaMbty_ghAAEw_tYTw1HqJ5JrE-jRh_Ujw&usqp=CAU")!, targetDate: Date.now.addingTimeInterval(-100000), schedulingDate: Date.now.addingTimeInterval(-1000), possibleDates: nil, coordinate: CLLocation(latitude: 42.32583, longitude: -83.05903), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd9VR1KrMZKnt8Yw_PBXt4nzae1NY5nnU8sw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652972359), schedulingDate: Date.now.addingTimeInterval(-500000), possibleDates: nil, scheduledDate: Date.now, isActive: true, coordinate: CLLocation(latitude: 42.33824, longitude: -83.06072), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")!, targetDate: Date(), possibleDates: nil, coordinate: CLLocation(latitude: 42.31443, longitude: -83.04480), lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")!, targetDate: Date(), possibleDates: nil, coordinate: CLLocation(latitude: 42.34283, longitude: -83.02556), lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QREJ3CgtpHBmIg6J-nyrgDjGvx62jxrTRQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976453), schedulingDate: Date.now.addingTimeInterval(-120000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(240000), coordinate: CLLocation(latitude: 42.32061, longitude: -83.02483), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[2].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QREJ3CgtpHBmIg6J-nyrgDjGvx62jxrTRQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976453), schedulingDate: Date.now.addingTimeInterval(-120000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(240000), coordinate: CLLocation(latitude: 42.32865, longitude: -83.07346), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[2].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, afterPicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652978394), schedulingDate: Date.now.addingTimeInterval(-1000000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(-100000), isActive: false, coordinate: CLLocation(latitude: 42.34146, longitude: -83.07192), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLebxkxbxEGaD877RrRm3ZVvl95UxsVdMJJQ&usqp=CAU")!, targetDate: Date(), possibleDates: nil, coordinate: CLLocation(latitude: 42.3799, longitude: -83.1019), lovers: [User.testData[0].id], attendees: [User.testData[0].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMtaMbty_ghAAEw_tYTw1HqJ5JrE-jRh_Ujw&usqp=CAU")!, targetDate: Date.now.addingTimeInterval(-100000), schedulingDate: Date.now.addingTimeInterval(-1000), possibleDates: nil, coordinate: CLLocation(latitude: 42.3748, longitude: -83.1105), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8QREJ3CgtpHBmIg6J-nyrgDjGvx62jxrTRQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652976453), schedulingDate: Date.now.addingTimeInterval(-120000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(240000), coordinate: CLLocation(latitude: 42.3836, longitude: -83.1118), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[2].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd9VR1KrMZKnt8Yw_PBXt4nzae1NY5nnU8sw&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652972359), schedulingDate: Date.now.addingTimeInterval(-500000), possibleDates: nil, scheduledDate: Date.now, isActive: true, coordinate: CLLocation(latitude: 42.3861, longitude: -82.9119), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id]),
        TrashMob(id: CKRecord.ID(), targetingUser: User.testData[0].id, beforePicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, afterPicture: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPOjbrF67Lmr3gMCUYnqWkwu4zcsDzfJggyQ&usqp=CAU")!, targetDate: Date(timeIntervalSince1970: 1652978394), schedulingDate: Date.now.addingTimeInterval(-1000000), possibleDates: nil, scheduledDate: Date.now.addingTimeInterval(-100000), isActive: false, coordinate: CLLocation(latitude: 42.4240, longitude: -83.1140), lovers: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id], attendees: [User.testData[0].id, User.testData[1].id, User.testData[2].id, User.testData[3].id, User.testData[4].id])
    ]
}
