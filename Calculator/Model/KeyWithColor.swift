//
//  KeyWithColor.swift
//  Calculator
//
//  Created by Elvis on 06/09/2023.
//

import Foundation
import SwiftUI

struct KeyWithColor: Identifiable {
    let id = UUID()
    
    let element: String
    let color: Color
}
