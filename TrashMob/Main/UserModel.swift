//
//  UserModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import Foundation

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String?
    var password: String?
    var premiumStatus: Bool
    var mobsTargeted: Set<UUID>
    var mobsCommitted: Set<UUID>
    var mobsCompleted: Set<UUID>
    var totalMobTime: Int?
    var profilePicture: URL?
    var notificationsLoved: Bool = false
    var notificationsLocal: Bool = false
    var notificationsDistance: Double = 10.0
    var notificationsLiked: Bool = false
    var mobsTargetedCount: Int {
        mobsTargeted.count
    }
    var mobsCommittedCount: Int {
        mobsCommitted.count
    }
    var mobsCompletedCount: Int {
        mobsCompleted.count
    }
//    var attendanceRate: Double = Double(mobsCommittedCount / mobsCompletedCount)
    
    static let testData = [
        User(name: "Kyle", password: "kyle", premiumStatus: false, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Dale", password: "dale", premiumStatus: true, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Jaelen", password: "dale", premiumStatus: true, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Angel", password: "dale", premiumStatus: false, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Ashlei", password: "dale", premiumStatus: true, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil)
    ]
}
