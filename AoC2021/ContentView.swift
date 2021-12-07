//
//  ContentView.swift
//  AoC2021
//
//  Created by Martin Václavík on 03.12.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    @State var showResult = false
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(1...24, id: \.self, content: { i in
                    NavigationLink("Day \(i)") {
                        ResultsView(viewModel: viewModel, day: i)
                    }.disabled(!viewModel.implementedDays.contains(i))
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
