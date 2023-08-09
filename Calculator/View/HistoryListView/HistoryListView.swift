//
//  HistoryListView.swift
//  Calculator
//
//  Created by Elvis on 03/08/2023.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var keyboardViewModel: KeyboardViewModel
    @StateObject var viewModel = HistoryListViewModel()
    
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .brightness(-0.1)
                .ignoresSafeArea()
            if viewModel.results.isEmpty {
                CalculatorEmptyView()
            } else {
                List {
                    ForEach(viewModel.results, id: \.self) { result in
                        VStack(alignment: .trailing, spacing: 10) {
                            Text(result.equation ?? "")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            Text(result.answer ?? "")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                        }
                        .onTapGesture {
                            switch keyboardViewModel.equation.last {
                            case "+", "-", "×", "÷":
                                keyboardViewModel.equation.append(result.answer ?? "")
                            default:
                                keyboardViewModel.equation = result.answer ?? ""
                            }
                        }
                    }
                    .onDelete(perform: { offsets in
                        viewModel.removeResults(offsets: offsets)
                    })
                    .listRowBackground(
                        Color("BackgroundColor")
                            .brightness(-0.1)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .trailing)
                    .foregroundColor(.white)
                }
            }
        }
        .navigationTitle("Records")
        .toolbarBackground(Color("BackgroundColor"))
        .toolbarBackground(.visible)
        .toolbarColorScheme(.dark)
        .toolbar(content: {
            ToolbarItem {
                Button("Remove all") {
                    viewModel.removeAllResults()
                    viewModel.fetchResults()
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .onAppear() {
            viewModel.fetchResults()
        }
        .onChange(of: keyboardViewModel.finish) { _ in
            viewModel.fetchResults()
        }
        .refreshable {
            viewModel.fetchResults()
        }
    }
        
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
            .environmentObject(KeyboardViewModel())
    }
}
