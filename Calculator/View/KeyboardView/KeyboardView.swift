//
//  KeyboardView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var viewModel: KeyboardViewModel
    
    var body: some View {
        Grid(horizontalSpacing: 15, verticalSpacing: 15) {
            ForEach(0..<viewModel.layout.count, id: \.self) { index in
                GridRow {
                    ForEach(viewModel.layout[index]) { item in
                        viewModel.customButton(data: item) {
                            viewModel.buildEquation(element: item.element)
                        }
                        .simultaneousGesture(
                            LongPressGesture()
                                .onEnded({ _ in
                                    if item.element == "DEL" {
                                        viewModel.equation.removeAll()
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    }
                                })
                        )
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(KeyboardViewModel())
    }
}
