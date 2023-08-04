//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct CalculatorButton: View {
    @State var isTap = false
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .shadow(radius: 5, x: 5, y: 5)
            Button(action: action) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(title: "1", action: {})
    }
}
