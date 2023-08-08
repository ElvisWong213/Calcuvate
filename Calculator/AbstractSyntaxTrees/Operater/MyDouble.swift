//
//  MyDouble.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class MyDouble: Node<Any> {
    override func print() -> String {
        return String(self.val as! Double)
    }
}
