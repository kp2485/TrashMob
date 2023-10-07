//
//  TrashMobViewModel.swift
//  TrashMob
//
//  Created by Zoe Cutler on 6/2/22.
//

import UIKit
import CloudKit

class TrashMobViewModel: ObservableObject {
    
    @Published var trashMobs: [TrashMob] = []
    @Published var selectedTrashMob: TrashMob? {
        didSet {
            if selectedTrashMob != nil {
                //                trashMobs.removeAll(where: { $0.id == selectedTrashMob!.id })
                //                trashMobs.append(selectedTrashMob!)
                
                if let index = trashMobs.firstIndex(where: { $0.id == selectedTrashMob!.id }) {
                    trashMobs[index] = selectedTrashMob!
                }
            }
        }
    }
    
    
    
    init() {
        //TODO: fetch nearby trashMobs from cloudkit
        fetchMobs()
        //        trashMobs = TrashMob.testData
    }
    
    func addButtonPressed(targetingUser: CKRecord.ID, beforePicture: Photo, coordinate2D: CLLocationCoordinate2D) {
        addMob(targetingUser: targetingUser, beforePicture: beforePicture, coordinate2D: coordinate2D)
    }
    
    private func addMob(targetingUser: CKRecord.ID, beforePicture: Photo, coordinate2D: CLLocationCoordinate2D) {
        //TODO: Make new addMob function, that adds the correct type of data
        
        let newMob = CKRecord(recordType: "Mobs")
        newMob["targetingUser"] = CKRecord.Reference(recordID: targetingUser, action: .none)
        newMob["targetDate"] = Date.now
        newMob["coordinate"] = CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        
        // image from TakeAPictureView
        guard
            let image = UIImage(data: beforePicture.originalData),
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("me.jpg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            //TODO: add real picture url
            //        if let url = URL(string: beforePictureURL) {
            //            newMob["beforePicture"] = CKAsset(fileURL: url)
            //        }
            
            newMob["beforePicture"] = asset
            saveMob(record: newMob)
        } catch let error {
            print(error)
        }
        
    }
    
    private func saveMob(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            
            // delay for peeps with slow internet
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.fetchMobs()
            }
        }
    }
    
    func fetchMobs() {
        
        let predicate = NSPredicate(value: true)
        //TODO: Get only the close ones
        //        let predicate = NSPredicate(format: "name = %@", argumentArray: ["elementToBeFiltered"])
        let query = CKQuery(recordType: "Mobs", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 20
        
        var returnedMobs: [TrashMob] = []
        
        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                    print("We got record")
                    
                    guard let targetingUser = record["targetingUser"] as? CKRecord.Reference else {
                        print("error with targeting user")
                        return
                    }
                    let imageAsset = record["beforePicture"] as? CKAsset
                    let imageURL = imageAsset?.fileURL
                    let imageAsset2 = record["afterPicture"] as? CKAsset
                    let imageURL2 = imageAsset2?.fileURL
                    guard let targetDate = record["targetDate"] as? Date else {
                        print("error with target date")
                        return
                    }
                    let schedulingDate = record["schedulingDate"] as? Date
                    let possibleDates = record["possibleDates"] as? [Date]
                    let scheduledDate = record["scheduledDate"] as? Date
                    let startedDate = record["startedDate"] as? Date
                    let completedDate = record["completedDate"] as? Date
                    guard let coordinate = record["coordinate"] as? CLLocation else {
                        print("error with coordinate")
                        return
                    }
                    
                    returnedMobs.append(TrashMob(
                        id: returnedRecordID,
                        targetingUser: targetingUser.recordID,
                        beforePicture: imageURL,
                        afterPicture: imageURL2,
                        targetDate: targetDate,
                        schedulingDate: schedulingDate,
                        possibleDates: possibleDates,
                        scheduledDate: scheduledDate,
                        startedDate: startedDate,
                        completedDate: completedDate,
                        coordinate: coordinate,
                        record: record
                    ))
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let targetingUser = returnedRecord["targetingUser"] as? CKRecord.Reference else { return }
                let imageAsset = returnedRecord["beforePicture"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                let imageAsset2 = returnedRecord["afterPicture"] as? CKAsset
                let imageURL2 = imageAsset2?.fileURL
                guard let targetDate = returnedRecord["targetDate"] as? Date else { return }
                let schedulingDate = returnedRecord["schedulingDate"] as? Date
                let possibleDates = returnedRecord["possibleDates"] as? [Date]
                let scheduledDate = returnedRecord["scheduledDate"] as? Date
                let startedDate = returnedRecord["startedDate"] as? Date
                let completedDate = returnedRecord["completedDate"] as? Date
                guard let coordinate = returnedRecord["coordinate"] as? CLLocation else { return }
                //TODO: Store a new TrashMob for older iOS
                returnedMobs.append(TrashMob(
                    id: returnedRecord.recordID,
                    targetingUser: targetingUser.recordID,
                    beforePicture: imageURL,
                    afterPicture: imageURL2,
                    targetDate: targetDate,
                    schedulingDate: schedulingDate,
                    possibleDates: possibleDates,
                    scheduledDate: scheduledDate,
                    startedDate: startedDate,
                    completedDate: completedDate,
                    coordinate: coordinate,
                    record: returnedRecord
                ))
            }
        }
        
        if #available(iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED queryResultBlock: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.trashMobs = returnedMobs
                }
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnedError) in
                print("RETURNED queryCompletionBlock")
                DispatchQueue.main.async {
                    self?.trashMobs = returnedMobs
                }
            }
        }
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    //    TODO: Implement update mob with record
    func updateSchedulingDate(mob: TrashMob) {
        let record = mob.record
        record!["schedulingDate"] = Date.now
        saveMob(record: record!)
    }
    
    func updateScheduledDate(mob: TrashMob) {
        let record = mob.record
        record!["scheduledDate"] = mob.scheduledDate
    }
    
    func updateActiveDate(mob: TrashMob) {
        let record = mob.record
        record!["startedDate"] = mob.startedDate
    }
    
    func updateCompletedDate(mob: TrashMob) {
        let record = mob.record
        record!["completedDate"] = mob.completedDate
    }
    
    func updateLoves(mob: TrashMob) {
        let record = mob.record
        record!["loves"] = mob.loves
    }
    
    // TODO: move off test data to CloudKit
    func getUserName(for userId: CKRecord.ID) -> String {
        if let user = User.testData.first(where: { $0.id == userId }) {
            return user.userName ?? "Anonymous"
        }
        return "Anonymous"
    }
    
    //    func deleteMob(indexSet: IndexSet) {
    //        guard let index =  indexSet.first else { return }
    //        let mob = trashMobs[index]
    ////        let record = selectedTrashMob?.record
    //        let record = CKRecord(recordType: "Mobs")
    //
    //        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
    //            DispatchQueue.main.async {
    //                self?.trashMobs.remove(at: index)
    //            }
    //        }
    //    }
}
