//
//  DisplayNumberView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct DisplayNumberView: View {
    @EnvironmentObject var keyboardViewModel: KeyboardViewModel
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            Text(keyboardViewModel.history.isEmpty ? " ": keyboardViewModel.history)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.gray)
            HStack {
                Spacer()
                Text(keyboardViewModel.equation.isEmpty ? "0" : keyboardViewModel.equation)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .id(keyboardViewModel.equation)
                    .transition(.offset(x: keyboardViewModel.isEqualPress ? -20 : 0))
                    .animation(
                        .spring(response: 0.2, dampingFraction: 0.3, blendDuration: 1),
                        value: keyboardViewModel.isEqualPress)
            }
            .contentShape(Rectangle())
        }
        .lineLimit(1)
        .minimumScaleFactor(0.1)
        .background(Color("BackgroundColor"))
        .onChange(of: keyboardViewModel.isEqualPress) { _ in
            keyboardViewModel.isEqualPress = false
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayNumberView()
            .environmentObject(KeyboardViewModel())
    }
}
