//
//  Subtract.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class Subtract: InfixOperation {
    init(left: Node<Any>, right: Node<Any>) {
        super.init(val: "-", left: left, right: right)
    }
    
    override func eval() throws -> Double {
        let nodeLeft = try left.eval()
        let nodeRight = try right.eval()
        return nodeLeft - nodeRight
    }
    
    override func print() -> String {
        return "(\(left.print())-\(right.print()))"
    }
}
