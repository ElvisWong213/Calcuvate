//
//  BasicCalculatorViewModel.swift
//  Calculator
//
//  Created by Elvis on 03/08/2023.
//

import Foundation

class BasicCalculatorViewModel: ObservableObject {
    @Published var history: String = ""
    @Published var equation: String = ""
    @Published var finish = false
    
    func buildEquation(element: String) {
        switch element {
        case "AC":
            equation = ""
        case "=":
            do {
                history = equation
                equation = try findAns()
                finish = true
                addResults()
            } catch {
                history = ""
                equation = "Syntax Error"
            }
            break
        case "(":
            break
        case ")":
            break
        case "+", "-", "×", "÷":
            if equation.contains("Syntax Error") {
                equation.removeAll()
            }
            finish = false
            equation.append(element)
        default:
            if equation.contains("Syntax Error") {
                equation.removeAll()
            }
            if finish {
                equation.removeAll()
                finish = false
            }
            equation.append(element)
        }
    }
    
    private func toPostfix() throws -> [String] {
        var stack: [String] = []
        var operatorStack: [String] = []
        var buffer: String = ""
        var numCounter = 0
        var operatorCounter = 0
        for element in equation {
            switch element {
            case "+", "-", "×", "÷":
                if !buffer.isEmpty {
                    numCounter += 1
                    stack.append(buffer)
                    buffer.removeAll()
                }
                if let lastOPerator = operatorStack.last {
                    if operatorPriority(input: String(element)) <= operatorPriority(input: lastOPerator) {
                        stack.append(operatorStack.popLast()!)
                    }
                }
                if element == "-" && buffer.isEmpty && stack.isEmpty {
                    buffer.append(element)
                } else {
                    operatorCounter += 1
                    operatorStack.append(String(element))
                }
            case "%":
                break
            case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".":
                buffer.append(element)
            default:
                throw CalCulatorError.SyntaxError
            }
        }
        if !buffer.isEmpty {
            numCounter += 1
            stack.append(buffer)
            buffer.removeAll()
        }
        if !operatorStack.isEmpty {
            stack.append(contentsOf: operatorStack.reversed())
            operatorStack.removeAll()
        }
        print(stack)
        if operatorCounter != numCounter - 1 {
            throw CalCulatorError.SyntaxError
        }
        return stack
    }
    
    func findAns() throws -> String {
        guard let postfix = try? toPostfix() else {
            throw CalCulatorError.SyntaxError
        }
        var stack: [Double] = []
        for element in postfix {
            switch element {
            case "+":
                guard let first = stack.popLast() else {
                    break
                }
                guard let second = stack.popLast() else {
                    break
                }
                stack.append(second + first)
            case "-":
                guard let first = stack.popLast() else {
                    break
                }
                guard let second = stack.popLast() else {
                    break
                }
                stack.append(second - first)
            case "×":
                guard let first = stack.popLast() else {
                    break
                }
                guard let second = stack.popLast() else {
                    break
                }
                stack.append(second * first)
            case "÷":
                guard let first = stack.popLast() else {
                    break
                }
                guard let second = stack.popLast() else {
                    break
                }
                stack.append(second / first)
            default:
                stack.append(Double(element)!)
            }
        }
        if stack.count == 1 {
            return String(stack[0])
        }
        return ""
    }
    
    private func operatorPriority(input: String) -> Int {
        switch input {
        case "+", "-":
            return 1
        case "×", "÷":
            return 2
        default:
            return 0
        }
    }
    
    private func addResults() {
        let context = DataManager.share.container.viewContext
        let newResult = CalculatorHistory(context: context)
        newResult.id = UUID()
        newResult.createDate = Date()
        newResult.equation = history
        newResult.answer = equation
        DataManager.share.saveContext()
    }
    
}

enum CalCulatorError: Error {
    case SyntaxError
}
