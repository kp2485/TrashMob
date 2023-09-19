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
    var record: CKRecord?
    var userName: String?
    var email: String?
    var joinDate: Date = Date()
    var premiumStatus: Bool = true
    var mobsTargeted: Set<CKRecord.ID> = Set<CKRecord.ID>()
    var mobsLoved: Set<CKRecord.ID> = Set<CKRecord.ID>()
    var mobsCommitted: Set<CKRecord.ID> = Set<CKRecord.ID>()
    var mobsCompleted: Set<CKRecord.ID> = Set<CKRecord.ID>()
    var totalMobTime: Double?
    var profilePicture: URL?
    var notificationsLoved: Bool = false
    var notificationsLocal: Bool = false
    var notificationsDistance: Double = 10.0
//    var notificationsLiked: Bool = false
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
        
    public static func getUserName(from record: CKRecord) -> String {
        let userName = record["userName"] as? String
        return userName ?? "Anonymous"
    }
    
    public static func convertUser(from record: CKRecord) -> User {
        
        let userName = record["userName"] as? String
        let email = record["email"] as? String
        let joinDate = record["joinDate"] as? Date
        let premiumStatus = record["premiumStatus"] as? Bool
        let mobsTargeted = (NSArray() as? [CKRecord.ID]).map(Set.init)
        let mobsLoved = (NSArray() as? [CKRecord.ID]).map(Set.init)
        let mobsCommitted = (NSArray() as? [CKRecord.ID]).map(Set.init)
        let mobsCompleted = (NSArray() as? [CKRecord.ID]).map(Set.init)
        let totalMobTime = record["totalMobTime"] as? Double
        let imageAsset = record["profilePicture"] as? CKAsset
        let imageURL = imageAsset?.fileURL
        let notificationsLoved = record["notificationsLoved"] as? Bool
        let notificationsLocal = record["notificationsLocal"] as? Bool
        let notificationsDistance = record["notificationsDistance"] as? Double
        
        return User(
            id: record.recordID,
            record: record,
            userName: userName,
            email: email,
            joinDate: joinDate ?? Date(),
            premiumStatus: premiumStatus ?? false,
            mobsTargeted: mobsTargeted ?? Set<CKRecord.ID>(),
            mobsLoved: mobsLoved ?? Set<CKRecord.ID>(),
            mobsCommitted: mobsCommitted ?? Set<CKRecord.ID>(),
            mobsCompleted: mobsCompleted ?? Set<CKRecord.ID>(),
            totalMobTime: totalMobTime ?? 0.0,
            profilePicture: imageURL,
            notificationsLoved: notificationsLoved ?? false,
            notificationsLocal: notificationsLocal ?? false,
            notificationsDistance: notificationsDistance ?? 10.0
        )
    }
}
