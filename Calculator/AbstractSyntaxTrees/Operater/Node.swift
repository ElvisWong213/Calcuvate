//
//  Node.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class Node<T: Any> {
    internal var val: T
    
    init(val: T) {
        self.val = val
    }
    
    func getVal() -> T {
        return self.val
    }
    
    func setVal(val: T) {
        self.val = val
    }
    
    func eval() -> Double {
        return self.val as! Double
    }
    
    func print() -> String {
        return self.val as! String
    }
}
