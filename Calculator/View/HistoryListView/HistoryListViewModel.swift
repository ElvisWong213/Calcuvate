//
//  HistoryListViewModel.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation
import CoreData

class HistoryListViewModel: ObservableObject {
    private let viewContext = DataManager.shared.viewContext
    @Published var results: [CalculatorHistory] = []
    
    init() {
        fetchResults()
    }
    
    func fetchResults() {
        let fetchRequest: NSFetchRequest<CalculatorHistory> = CalculatorHistory.fetchRequest()
        fetchRequest.sortDescriptors = [.init(key: "createDate", ascending: false)]
        do {
            results = try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching result: \(error)")
        }
    }
    
    func removeResults(offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(results.remove(at: index))
        }
        DataManager.shared.saveContext()
    }
    
    func removeAllResults() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CalculatorHistory.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(batchDeleteRequest)
            DataManager.shared.saveContext()
        } catch {
            print("Unable to remove all data: \(error.localizedDescription)")
        }
    }
    
}
