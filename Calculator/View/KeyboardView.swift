//
//  KeyboardView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var basicCalculatorViewModel: BasicCalculatorViewModel
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
    
    var body: some View {
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            ForEach(0..<layout.count, id: \.self) { index in
                GridRow {
                    ForEach(layout[index]) { item in
                        customButton(data: item) {
                            basicCalculatorViewModel.buildEquation(element: item.element)
                        }
                    }
                }
            }
        }
        .scaledToFit()
        .padding()
    }
    
    @ViewBuilder
    func customButton(data: NumberWithColor, action: @escaping () -> Void) -> some View {
        if data.element != "0" {
            CalculatorButton(title: data.element, action: action)
                .aspectRatio(1.0, contentMode: .fit)
                .scaledToFill()
                .foregroundColor(data.color)
        } else {
            CalculatorButton(title: data.element, action: action)
                .gridCellColumns(2)
                .foregroundColor(data.color)
            
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}

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
