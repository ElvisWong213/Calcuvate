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
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            ForEach(0..<viewModel.layout.count, id: \.self) { index in
                GridRow {
                    ForEach(viewModel.layout[index]) { item in
                        viewModel.customButton(data: item) {
                            viewModel.buildEquation(element: item.element)
                        }
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
