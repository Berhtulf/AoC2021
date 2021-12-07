//
//  ViewModel.swift
//  AoC2021
//
//  Created by Martin Václavík on 03.12.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    var solver = AoCSolver()
    var implementedDays = [1,2]
    @Published var result = [String]()
    
    //MARK: - Intent(s)
    func solveDay(_ index: Int) {
        result.removeAll()
        
        switch index {
        case 1:
            result = solver.solveDay1()
        case 2:
            result = solver.solveDay2()
        default:
            break
        }
    }
}
