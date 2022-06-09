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
    var premiumStatus: Bool
    var mobsTargeted: Set<UUID> = []
    var mobsCommitted: Set<UUID> = []
    var mobsCompleted: Set<UUID> = []
    var totalMobTime: TimeInterval?
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
        User(name: "Kyle", premiumStatus: false, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Dale", premiumStatus: true, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Jaelen", premiumStatus: true, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Angel", premiumStatus: false, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Ashlei", premiumStatus: true, mobsTargeted: [], mobsCommitted: [], mobsCompleted: [], profilePicture: nil)
    ]
}
