//
//  DisplayNumberView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct DisplayNumberView: View {
    @EnvironmentObject var basicCalculatorViewModel: BasicCalculatorViewModel
    @State var swip = false
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text(basicCalculatorViewModel.history)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                Text(basicCalculatorViewModel.equation.isEmpty ? "0" : basicCalculatorViewModel.equation)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .animation(.easeIn(duration: 0.2), value: basicCalculatorViewModel.history)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        }
        .padding()
        .gesture(
            DragGesture()
                .onChanged{ value in
                    print(value)
                    if value.translation.width > 5 && swip {
                        if !basicCalculatorViewModel.equation.isEmpty {
                            basicCalculatorViewModel.equation.removeLast()
                        }
                        swip = false
                    }
                }
                .onEnded { value in
                    swip = true
                }
        )
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayNumberView()
            .background(Color("BackgroundColor"))
            .environmentObject(BasicCalculatorViewModel())
    }
}
