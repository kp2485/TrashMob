//
//  User.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

struct User: Codable {
    var name: String?
    var password: String?
    var id: Int?
    var mobsTargeted: Int?
    var mobsCompleted: Int?
    var points: Int?
}
