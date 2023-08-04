//
//  HistoryListView.swift
//  Calculator
//
//  Created by Elvis on 03/08/2023.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var basicCalculatorViewModel: BasicCalculatorViewModel
    @StateObject var historyListViewModel = HistoryListViewModel()
    
    var body: some View {
        List {
            ForEach(historyListViewModel.results, id: \.self) { result in
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
                    basicCalculatorViewModel.equation = result.answer ?? ""
                }
            }
            .onDelete(perform: { index in
                historyListViewModel.removeResults(offsets: index)
                historyListViewModel.fetchResults()
            })
            .listRowBackground(
                Color("BackgroundColor")
                .brightness(-0.1)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .trailing)
            .foregroundColor(.white)
        }
        .navigationTitle("Records")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("BackgroundColor"))
        .toolbarBackground(.visible)
        .toolbarColorScheme(.dark)
        .overlay(content: {
            if historyListViewModel.results.isEmpty {
                ZStack {
                    Color("BackgroundColor")
                        .brightness(-0.1)
                    Text("Use calculator to add record")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }
        })
        .background() {
            Color("BackgroundColor")
                .brightness(-0.1)
        }
        .scrollContentBackground(.hidden)
        .onAppear() {
            historyListViewModel.fetchResults()
        }
        .onChange(of: basicCalculatorViewModel.finish) { _ in
            historyListViewModel.fetchResults()
        }
        
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
            .environmentObject(BasicCalculatorViewModel())
    }
}
