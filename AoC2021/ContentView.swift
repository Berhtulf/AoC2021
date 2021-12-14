//
//  ContentView.swift
//  AoC2021
//
//  Created by Martin Václavík on 03.12.2021.
//

import SwiftUI
import os

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var day: Int = 1
    @State var importingFile = false
    
    @State var data = ""
    
    @State var showResult = false
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Section{
                    Picker("Solve day", selection: $day) {
                        ForEach(viewModel.implementedDays, id: \.self){ dayIndex in
                            Text("\(dayIndex)").tag(dayIndex)
                        }
                    }
                } header: {
                    Text("Configuration")
                }
                Divider()
                Section{
                    Button("Import file") {
                        importingFile = true
                    }
                    .buttonStyle(.borderedProminent)
                    .fileImporter(isPresented: $importingFile,
                                  allowedContentTypes: [.plainText],
                                  allowsMultipleSelection: false,
                                  onCompletion: { result in
                        do {
                            guard let selectedFile: URL = try result.get().first else { return }
                            guard let inputString = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                            
                            data = inputString
                        } catch {
                            let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "fileimport")
                            logger.log("Failed to load file data")
                        }
                    })
                    TextField("Or enter input", text: $data, prompt: nil)
                } header : {
                    Text("Source data")
                }

                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
