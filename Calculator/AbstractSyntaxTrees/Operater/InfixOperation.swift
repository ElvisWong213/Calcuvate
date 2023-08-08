//
//  InfixOperation.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class InfixOperation: Node<Any> {
    internal var right: Node<Any>
    internal var left: Node<Any>
    
    init(val: Any, left: Node<Any>, right: Node<Any>) {
        self.right = right
        self.left = left
        super.init(val: val)
    }
    
    func getRight() -> Node<Any> {
        return self.right
    }
    
    func getLeft() -> Node<Any> {
        return self.left
    }
    
    func setRight(node: Node<Any>) {
        self.right = node
    }
    
    func setLeft(node: Node<Any>) {
        self.left = node
    }
}
