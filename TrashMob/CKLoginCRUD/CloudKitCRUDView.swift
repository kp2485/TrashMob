//
//  CloudKitCRUDView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 4/26/22.
//

import SwiftUI
import CloudKit

struct MobModel: Hashable {
    let name: String
    var loves: Int
    var trashMobState: String
    let beforePicURL: URL?
    let record: CKRecord
}

enum TrashMobState {
    case loading
    case targeted
    case scheduling
    case scheduled
    case inProgress
    case completed
}

class CloudKitCRUDViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var loves: Int = 0
    @Published var trashMobState: TrashMobState
    
    @Published var mobs: [MobModel] = []
    
    
    init() {
        fetchMobs()
    }
    
    func addButtonPressed() {
        guard !text.isEmpty else { return }
        
        addMob(name: text)
    }
    
    private func addMob(name: String) {
        let newMob = CKRecord(recordType: "Mobs")
        newMob["name"] = name
        newMob["loves"] = loves
        
        // switch to image from TakeAPictureView
        guard
            let image = UIImage(named: "me"),
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("me.jpg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newMob["image"] = asset
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
                self?.text = ""
                self?.fetchMobs()
            }
        }
    }
    
    func fetchMobs() {
        
        let predicate = NSPredicate(value: true)
        //        let predicate = NSPredicate(format: "name = %@", argumentArray: ["elementToBeFiltered"])
        let query = CKQuery(recordType: "Mobs", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 20
        
        var returnedMobs: [MobModel] = []
        
        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                    guard let name = record["name"] as? String else { return }
                    let imageAsset = record["image"] as? CKAsset
                    let imageURL = imageAsset?.fileURL
                    returnedMobs.append(MobModel(name: name, loves: self.loves, trashMobState: "targeted", beforePicURL: imageURL, record: record))
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let name = returnedRecord["name"] as? String else { return }
                let imageAsset = returnedRecord["image"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                returnedMobs.append(MobModel(name: name, loves: self.loves, trashMobState: <#String#>, beforePicURL: imageURL, record: returnedRecord))
            }
        }
        
        if #available(iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED queryResultBlock: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.mobs = returnedMobs
                }
                
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnedError) in
                print("RETURNED queryCompletionBlock")
                DispatchQueue.main.async {
                    self?.mobs = returnedMobs
                }
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func updateMob(mob: MobModel) {
        let record = mob.record
        record["name"] = "NEW NAME!!!"
        saveMob(record: record)
    }
    
    func deleteMob(indexSet: IndexSet) {
        guard let index =  indexSet.first else { return }
        let mob = mobs[index]
        let record = mob.record
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self?.mobs.remove(at: index)
            }
        }
    }
}

struct CloudKitCRUDView: View {
    
    @StateObject private var vm = CloudKitCRUDViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                header
                textField
                addButton
                
                List {
                    ForEach(vm.mobs, id: \.self) { mob in
                        VStack {
                            HStack {
                                Text(mob.name)
                                
                                ZStack {
                                    Image(systemName: "heart")
                                    Text("0")
                                }
                            }
                            
                            // Download binary from URL and display
                            if let url = mob.beforePicURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .onTapGesture {
                            vm.updateMob(mob: mob)
                        }
                    }
                    .onDelete(perform: vm.deleteMob)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct CloudKitCRUDView_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCRUDView()
    }
}

extension CloudKitCRUDView {
    
    private var header: some View {
        Text ("🗑 ♻️ Trash Mob 💃🏽 🕺🏼")
            .font(.headline)
    }
    
    private var textField: some View {
        TextField("Name of Location or Intersection...", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(20)
    }
    
    private var addButton: some View {
        Button {
            vm.addButtonPressed()
        } label: {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.cyan)
                .cornerRadius(20)
        }
    }
}
