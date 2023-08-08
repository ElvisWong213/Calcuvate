//
//  Negate.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class Negate: Node<Any> {
    private var arg: Node<Any>
    
    init(arg: Node<Any>) {
        self.arg = arg
        super.init(val: "-")
    }
    
    override func eval() -> Double {
        return -1 * arg.eval()
    }
    
    override func print() -> String {
        return "-(\(arg.print()))"
    }
}
