//
//  KeyboardViewModel.swift
//  Calculator
//
//  Created by Elvis on 04/08/2023.
//

import Foundation
import SwiftUI

class KeyboardViewModel: ObservableObject {
    @Published var history: String = ""
    @Published var equation: String = ""
    @Published var finish = false
    
    let layout: [[NumberWithColor]] =
    [
        [.init(element: "AC", color: KeyboardColor.operatorColor2.color), .init(element: "(", color: KeyboardColor.operatorColor2.color), .init(element: ")", color: KeyboardColor.operatorColor2.color), .init(element: "÷", color: KeyboardColor.operatorColor.color)],
        [.init(element: "7", color: KeyboardColor.numberColor.color), .init(element: "8", color: KeyboardColor.numberColor.color), .init(element: "9", color: KeyboardColor.numberColor.color), .init(element: "×", color: KeyboardColor.operatorColor.color)],
        [.init(element: "4", color: KeyboardColor.numberColor.color), .init(element: "5", color: KeyboardColor.numberColor.color), .init(element: "6", color: KeyboardColor.numberColor.color), .init(element: "-", color: KeyboardColor.operatorColor.color)],
        [.init(element: "1", color: KeyboardColor.numberColor.color), .init(element: "2", color: KeyboardColor.numberColor.color), .init(element: "3", color: KeyboardColor.numberColor.color), .init(element: "+", color: KeyboardColor.operatorColor.color)],
        [.init(element: "0", color: KeyboardColor.numberColor.color), .init(element: ".", color: KeyboardColor.numberColor.color), .init(element: "=", color: KeyboardColor.operatorColor.color)]
    ]
    //        ["AC", "(", ")", "/"],
    //        ["7", "8", "9", "X"],
    //        ["4", "5", "6", "-"],
    //        ["1", "2", "3", "+"],
    //        ["0", ".", "="]
    
    @ViewBuilder
    func customButton(data: NumberWithColor, action: @escaping () -> Void) -> some View {
        if data.element != "0" {
            CalculatorButton(title: data.element, action: action)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(data.color)
        } else {
            CalculatorButton(title: data.element, action: action)
                .gridCellColumns(2)
                .foregroundColor(data.color)
        }
    }
}

extension KeyboardViewModel {
    struct NumberWithColor: Identifiable {
        let id = UUID()
        
        let element: String
        let color: Color
    }

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
}

extension KeyboardViewModel {
    func buildEquation(element: String) {
        switch element {
        case "AC":
            equation = ""
        case "=":
            do {
                if finish == false {
                    history = equation
                    equation = try findAns()
                    finish = true
                    addResults()
                }
            } catch {
                history = ""
                equation = "Syntax Error"
            }
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
        var quotationCounter = 0
        for element in equation {
            switch element {
            case "+", "-", "×", "÷":
                if !buffer.isEmpty {
                    if buffer == "." {
                        throw CalCulatorError.SyntaxError
                    }
                    numCounter += 1
                    stack.append(buffer)
                    buffer.removeAll()
                }
                while operatorStack.last != nil {
                    if let lastOperator = operatorStack.last {
                        if operatorPriority(input: String(element)) <= operatorPriority(input: lastOperator) {
                            stack.append(operatorStack.popLast()!)
                        } else {
                            break
                        }
                    }
                }
                operatorCounter += 1
                operatorStack.append(String(element))
            case "(":
                if !buffer.isEmpty {
                    if buffer == "." {
                        throw CalCulatorError.SyntaxError
                    }
                    numCounter += 1
                    stack.append(buffer)
                    buffer.removeAll()
                }
                quotationCounter += 1
                operatorStack.append(String(element))
            case ")":
                if !buffer.isEmpty {
                    if buffer == "." {
                        throw CalCulatorError.SyntaxError
                    }
                    numCounter += 1
                    stack.append(buffer)
                    buffer.removeAll()
                }
                while operatorStack.last != nil {
                    if operatorStack.last != "(" {
                        stack.append(operatorStack.popLast()!)
                    } else {
                        operatorStack.removeLast()
                        quotationCounter -= 1
                        break
                    }
                }
            case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".":
                buffer.append(element)
            default:
                throw CalCulatorError.SyntaxError
            }
        }
        if !buffer.isEmpty {
            if buffer == "." {
                throw CalCulatorError.SyntaxError
            }
            numCounter += 1
            stack.append(buffer)
            buffer.removeAll()
        }
        if !operatorStack.isEmpty {
            stack.append(contentsOf: operatorStack.reversed())
            operatorStack.removeAll()
        }
        print(stack)
        if operatorCounter != numCounter - 1 || quotationCounter != 0 {
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
            return String(format: "%.3f", stack[0])
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
