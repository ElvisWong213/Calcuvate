//
//  BasicCalculatorView.swift
//  Calculator
//
//  Created by Elvis on 02/08/2023.
//

import SwiftUI

struct BasicCalculatorView: View {
    @StateObject var basicCalculatorViewModel = BasicCalculatorViewModel()
    @State var showBottomSheet = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .brightness(-0.1)
                VStack {
                    HistoryListView()
                        .frame(height: UIScreen.main.bounds.height * 0.8)
                        .environmentObject(basicCalculatorViewModel)
                        .sheet(isPresented: $showBottomSheet) {
                            GeometryReader { gr in
                                VStack {
                                    Spacer()
                                    DisplayNumberView()
                                        .frame(minWidth: gr.size.height * 0.3)
                                        .fixedSize(horizontal: false, vertical: true)
                                    KeyboardView()
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .environmentObject(basicCalculatorViewModel)
                                .presentationDetents([.fraction(0.1), .fraction(0.8)])
                                .presentationBackgroundInteraction(.enabled)
                                .presentationDragIndicator(.visible)
                                .presentationBackground(Color("BackgroundColor"))
                                .interactiveDismissDisabled()
                            }
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
