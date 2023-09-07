//
//  SheetView.swift
//  Calculator
//
//  Created by Elvis on 07/09/2023.
//

import SwiftUI

struct SheetView: View {
    @EnvironmentObject var keyboardViewModel: KeyboardViewModel
    var body: some View {
        GeometryReader { gr in
            VStack {
                Spacer()
                DisplayNumberView()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                KeyboardView()
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .presentationDetents([.fraction(0.2), .fraction(0.8)])
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.hidden)
            .background(Color("BackgroundColor"))
            .interactiveDismissDisabled()
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
            .environmentObject(KeyboardViewModel())
    }
}
