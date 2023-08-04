//
//  HistoryListViewModel.swift
//  Calculator
//
//  Created by Elvis on 03/08/2023.
//

import Foundation
import CoreData

class HistoryListViewModel: ObservableObject {
    @Published var results: [CalculatorHistory] = [CalculatorHistory]()
    
    func fetchResults() {
        let context = DataManager.share.container.viewContext
        let fetchRequest: NSFetchRequest<CalculatorHistory> = CalculatorHistory.fetchRequest()
        fetchRequest.sortDescriptors = [.init(key: "createDate", ascending: false)]
        do {
            self.results = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching result: \(error)")
        }
    }
    
    func removeResults(offsets: IndexSet) {
        let context = DataManager.share.container.viewContext
        for index in offsets {
            let data = results[index]
            context.delete(data)
        }
        DataManager.share.saveContext()
    }
    
    func removeAllResults() {
        let context = DataManager.share.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CalculatorHistory.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            DataManager.share.saveContext()
        } catch {
            print("Unable to remove all data: \(error.localizedDescription)")
        }
    }
}
