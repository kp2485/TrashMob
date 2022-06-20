//
//  UserModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import Foundation

struct User: Identifiable, Hashable {
    var id = UUID()
    var userName: String?
    var joinDate: Date = Date()
    var premiumStatus: Bool = true
    var mobsTargeted: Set<UUID> = []
    var mobsLoved: Set<UUID> = []
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
    var mobsLovedCount: Int {
        mobsLoved.count
    }
    var mobsCommittedCount: Int {
        mobsCommitted.count
    }
    var mobsCompletedCount: Int {
        mobsCompleted.count
    }
    var reliability: Double? {
        Double(mobsCommittedCount) / Double(mobsCompletedCount)
    }
    
    static let testData = [
        User(userName: "Kyle", premiumStatus: false),
        User(userName: "Dale", premiumStatus: true),
        User(userName: "Jaelen", premiumStatus: true),
        User(userName: "Angel", premiumStatus: false),
        User(userName: "Ashlei", premiumStatus: true)
    ]
}
