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
        //        fetchMobs()
        trashMobs = TrashMob.testData
    }
    
    func addButtonPressed(targetingUser: String, beforePictureURL: String, coordinate2D: CLLocationCoordinate2D) {
        addMob(targetingUser: targetingUser, beforePictureURL: beforePictureURL, coordinate2D: coordinate2D)
    }
    
    private func addMob(targetingUser: String, beforePictureURL: String, coordinate2D: CLLocationCoordinate2D) {
        //TODO: Make new addMob function, that adds the correct type of data
        //        let newMob = CKRecord(recordType: "Mobs")
        //        newMob["name"] = name
        //        newMob["loves"] = loves
        //        newMob["trashMobState"] = trashMobState
        let newMob = CKRecord(recordType: "Mobs")
        newMob["targetingUser"] = targetingUser
        newMob["targetDate"] = Date.now
        newMob["coordinate"] = CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        
        
        // switch to image from TakeAPictureView
        guard
            let image = UIImage(named: "me"),
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
                    print("nothing")
                    //TODO: Store a new TrashMob
                    //                    guard let name = record["name"] as? String else { return }
                    //                    let imageAsset = record["image"] as? CKAsset
                    //                    let imageURL = imageAsset?.fileURL
                    //                    returnedMobs.append(MobModel(name: name, loves: self.loves, beforePicURL: imageURL, record: record))
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let name = returnedRecord["name"] as? String else { return }
                let imageAsset = returnedRecord["image"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                //TODO: Store a new TrashMob for older iOS
                //                returnedMobs.append(MobModel(name: name, loves: self.loves, beforePicURL: imageURL, record: returnedRecord))
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
    
    //TODO: Implement update mob with record
    //    func updateMob(mob: TrashMob) {
    //        let record = mob.record
    //        record["name"] = "NEW NAME!!!"
    //        saveMob(record: record)
    //    }
    
    func deleteMob(indexSet: IndexSet) {
        guard let index =  indexSet.first else { return }
        let mob = trashMobs[index]
        //        let record = mob.record
        let record = CKRecord(recordType: "Mobs")
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self?.trashMobs.remove(at: index)
            }
        }
    }
}
