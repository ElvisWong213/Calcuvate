//
//  KeyboardColor.swift
//  Calculator
//
//  Created by Elvis on 06/09/2023.
//

import Foundation
import SwiftUI

enum KeyboardColor {
    case numberColor, operatorColor, operatorColor2
    
    var color: Color {
        switch self {
        case .numberColor:
            return Color("NumberColor")
        case .operatorColor:
            return Color("OperatorColor")
        case .operatorColor2:
            return Color("OperatorColor2")
        }
    }
}
