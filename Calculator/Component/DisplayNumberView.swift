//
//  DisplayNumberView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct DisplayNumberView: View {
    @EnvironmentObject var keyboardViewModel: KeyboardViewModel
    @State var swip = false
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text(keyboardViewModel.history.isEmpty ? " ": keyboardViewModel.history)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                Text(keyboardViewModel.equation.isEmpty ? "0" : keyboardViewModel.equation)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .animation(.easeIn(duration: 0.2), value: keyboardViewModel.history)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
        }
        .gesture(
            DragGesture()
                .onChanged{ value in
                    if value.translation.width > 5 && swip {
                        if !keyboardViewModel.equation.isEmpty {
                            keyboardViewModel.equation.removeLast()
                        }
                        swip = false
                    }
                }
                .onEnded { value in
                    swip = true
                }
        )
        .background(Color("BackgroundColor"))
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayNumberView()
            .environmentObject(KeyboardViewModel())
    }
}
