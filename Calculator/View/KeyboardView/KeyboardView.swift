//
//  KeyboardView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var keyboardViewModel: KeyboardViewModel
    
    var body: some View {
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            ForEach(0..<keyboardViewModel.layout.count, id: \.self) { index in
                GridRow {
                    ForEach(keyboardViewModel.layout[index]) { item in
                        keyboardViewModel.customButton(data: item) {
                            keyboardViewModel.buildEquation(element: item.element)
                        }
                    }
                }
            }
        }
        .scaledToFit()
        .padding()
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(KeyboardViewModel())
    }
}
