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
                        HStack {
                            Spacer()
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
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            switch keyboardViewModel.equation.last {
                            case "+", "-", "×", "÷":
                                keyboardViewModel.equation.append(result.answer ?? "")
                            default:
                                keyboardViewModel.equation = result.answer ?? ""
                            }
                        }
                        .contextMenu {
                            Button {
                                viewModel.copyResultToPasteboard(result: result.equation ?? "")
                            } label: {
                                HStack {
                                    Image(systemName: "function")
                                    Text("Copy equation")
                                }
                            }
                            Button {
                                viewModel.copyResultToPasteboard(result: result.answer ?? "")
                            } label: {
                                HStack {
                                    Image(systemName: "equal.square")
                                    Text("Copy answer")
                                }
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                viewModel.copyResultToPasteboard(result: result.answer ?? "")
                            } label: {
                                Text("Copy answer")
                            }
                            .tint(.green)
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
                .listStyle(.plain)
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
