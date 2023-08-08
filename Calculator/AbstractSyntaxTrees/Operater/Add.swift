//
//  Add.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class Add: InfixOperation {
    init(left: Node<Any>, right: Node<Any>) {
        super.init(val: "+", left: left, right: right)
    }
    
    override func eval() -> Double {
        return left.eval() + right.eval()
    }
    
    override func print() -> String {
        return "(\(left.print())+\(right.print()))"
    }
}
