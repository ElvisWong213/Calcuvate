//
//  CalCulatorError.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

enum CalCulatorError: String, LocalizedError {
    case SyntaxError = "SyntaxError"
    case MathError = "MathError"
    
    var errorDescription: String? {
        self.rawValue
    }
}
