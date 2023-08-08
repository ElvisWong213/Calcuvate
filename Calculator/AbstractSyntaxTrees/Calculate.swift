//
//  Calculate.swift
//  Calculator
//
//  Created by Elvis on 08/08/2023.
//

import Foundation

class Calculate {
    var input: String
    var index: Int
    var nextToken: Character
    
    init() {
        self.input = ""
        self.index = 0
        self.nextToken = " "
    }
    
    func perform(input: String) -> String {
        self.index = 0
        self.input = input
        scanToken()
        guard let result = parseE()?.eval() else {
            return ""
        }
        return String(result)
    }

    private func scanToken() {
        if index < input.count {
            nextToken = input[input.index(input.startIndex, offsetBy: index)]
            index += 1
        } else {
            nextToken = " "
        }
    }

    private func parseE() -> Node<Any>? {
        guard var a = parseT() else {
            return nil
        }
        while true {
            if nextToken == "+" {
                scanToken()
                guard let b = parseT() else {
                    return nil
                }
                a = Add(left: a, right: b)
            } else if nextToken == "-" {
                scanToken()
                guard let b = parseT() else {
                    return nil
                }
                a = Subtract(left: a, right: b)
            } else {
                return a
            }
        }
    }

    private func parseT() -> Node<Any>? {
        guard let a = parseF() else {
            return nil
        }
        if nextToken == "×" {
            scanToken()
            guard let b = parseT() else {
                return nil
            }
            return Multiplication(left: a, right: b)
        } else if nextToken == "÷" {
            scanToken()
            guard let b = parseT() else {
                return nil
            }
            return Division(left: a, right: b)
        } else {
            return a
        }
    }

    private func parseF() -> Node<Any>? {
        if nextToken.isNumber || nextToken == "." {
            var buffer = ""
            var dotCount = 0
            repeat {
                if dotCount > 1 {
                    return nil
                }
                if nextToken == "." {
                    dotCount += 1
                }
                buffer += String(nextToken)
                scanToken()
            } while nextToken.isNumber || nextToken == "."
            return MyDouble(val: Double(buffer)!)
        } else if nextToken == "(" {
            scanToken()
            let a = parseE()
            if a == nil {
                return nil
            }
            if nextToken == ")" {
                scanToken()
                return a
            } else {
                return nil
            }
        } else if nextToken == "-" {
            scanToken()
            return Negate(arg: parseF()!)
        } else {
            return nil
        }
    }
}
