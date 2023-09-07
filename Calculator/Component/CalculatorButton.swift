//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct CalculatorButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
            let impact = UIImpactFeedbackGenerator(style: .rigid)
            impact.impactOccurred()
        }) {
            Text(title)
        }
        .buttonStyle(CalculatorButtonStyle())
        
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(title: "1", action: {})
    }
}

fileprivate struct CalculatorButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fixedSize()
            .foregroundColor(.white)
            .font(.title)
            .bold()
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background() {
                Rectangle()
                    .brightness(configuration.isPressed ? 0.3 : 0)
                    .cornerRadius(10)
                    .shadow(radius: 5, x: 5, y: 5)
            }
    }
}
