//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

@main
struct CalculatorApp: App {
    @StateObject private var manager: DataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
