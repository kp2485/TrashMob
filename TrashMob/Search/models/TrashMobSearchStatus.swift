//
//  TrashMobSearchStatus.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

enum TrashMobSearchStatus: String, CaseIterable {
    case targeted
    case scheduled
    case inProgress = "in progress"
    case mobbed
}
