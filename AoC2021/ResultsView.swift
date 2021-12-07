//
//  ResultsView.swift
//  AoC2021
//
//  Created by Martin Václavík on 03.12.2021.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ViewModel
    let day: Int
    
    var body: some View {
        Form{
            if (viewModel.result.count > 0){
                Section(header: Image(systemName: "star.fill"), content: {
                    TextField("First star", text: $viewModel.result[0])
                })
            }
            if (viewModel.result.count > 1){
                Section(header: HStack{
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                }, content: {
                    TextField("Second star", text: $viewModel.result[1])
                })
            }
        }.onAppear(perform: {
            viewModel.solveDay(day)
        })
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(viewModel: ViewModel(), day: 1)
    }
}
