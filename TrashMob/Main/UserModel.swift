//
//  UserModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/24/22.
//

import Foundation
import CloudKit

struct User: Identifiable, Hashable {
    var id: CKRecord.ID
    var userName: String?
    var email: String?
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
        User(id: CKRecord.ID(), userName: "Kyle", premiumStatus: false),
        User(id: CKRecord.ID(), userName: "Dale", premiumStatus: true),
        User(id: CKRecord.ID(), userName: "Jaelen", premiumStatus: true),
        User(id: CKRecord.ID(), userName: "Angel", premiumStatus: false),
        User(id: CKRecord.ID(), userName: "Ashlei", premiumStatus: true)
    ]
}
