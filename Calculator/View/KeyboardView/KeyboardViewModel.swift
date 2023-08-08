//
//  KeyboardViewModel.swift
//  Calculator
//
//  Created by Elvis on 04/08/2023.
//

import Foundation
import SwiftUI

class KeyboardViewModel: ObservableObject {
    let calculate = Calculate()
    private let viewContext = DataManager.shared.viewContext
    
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
                    equation = String(try calculate.perform(input: equation))
                    finish = true
                    addResults()
                }
            } catch {
                history = ""
                equation = error.localizedDescription
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
    
    private func addResults() {
        let newResult = CalculatorHistory(context: viewContext)
        newResult.id = UUID()
        newResult.createDate = Date()
        newResult.equation = history
        newResult.answer = equation
        DataManager.shared.saveContext()
    }
}
