//
//  DataManager.swift
//  Calculator
//
//  Created by Elvis on 03/08/2023.
//

import Foundation
import CoreData

struct DataManager {
    static let shared = DataManager()
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if (inMemory) {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Date failed to load: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        if DataManager.shared.container.viewContext.hasChanges {
            do {
                try DataManager.shared.container.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//struct CalculatorHistory {
//    var id: UUID
//    var equation: String
//    var answer: String
//    var createDate: Date
//}
