//
//  BasicCalculatorView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct BasicCalculatorView: View {
    @StateObject var keyboardViewModel = KeyboardViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .brightness(-0.1)
                VStack {
                    HistoryListView()
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                        .environmentObject(keyboardViewModel)
                        .sheet(isPresented: .constant(true)) {
                            SheetView()
                                .environmentObject(keyboardViewModel)
                        }
                    Spacer()
                }
            }
        }
    }
}

struct BasicCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        BasicCalculatorView()
    }
}
