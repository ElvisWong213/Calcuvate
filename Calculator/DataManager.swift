//
//  DataManager.swift
//  Calculator
//
//  Created by Elvis on 03/08/2023.
//

import Foundation
import CoreData

class DataManager: NSObject, ObservableObject {
    static let share = DataManager()
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    override init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Date failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
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
