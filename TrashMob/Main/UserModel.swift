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
    var mobsCompletedCount: Int {
        mobsCompleted.count
    }
    
    static let testData = [
        User(name: "Kyle", password: "kyle", premiumStatus: false, mobsTargeted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Dale", password: "dale", premiumStatus: true, mobsTargeted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Jaelen", password: "dale", premiumStatus: true, mobsTargeted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Angel", password: "dale", premiumStatus: false, mobsTargeted: [], mobsCompleted: [], profilePicture: nil),
        User(name: "Ashlei", password: "dale", premiumStatus: true, mobsTargeted: [], mobsCompleted: [], profilePicture: nil)
    ]
}
