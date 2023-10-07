//
//  OrganizationModel.swift
//  TrashMob
//
//  Created by Kyle Peterson on 10/7/23.
//

import Foundation
import CloudKit

struct Organization: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var mission: String?
    var picture: URL?
    var coordinate: CLLocation?
    
    var leaders: Set<CKRecord.ID>
    var employees: Set<CKRecord.ID>
    var supporters: Set<CKRecord.ID>
    
    var totalLoves: Int = 0
    var mobsTargeted: Int = 0
    var mobsAttended: Int = 0
    var totalMinutes: Int = 0
}
