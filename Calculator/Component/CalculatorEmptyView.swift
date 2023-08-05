//
//  CalculatorEmptyView.swift
//  Calculator
//
//  Created by Elvis on 04/08/2023.
//

import SwiftUI

struct CalculatorEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Use calculator to add record")
                .font(.title3)
            Spacer()
            Image(systemName: "arrow.down")
                .font(.title)
            Spacer()
        }
        .foregroundColor(.white)
        .background(Color("BackgroundColor").brightness(-0.1))
    }
}

struct CalculatorEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorEmptyView()
    }
}
