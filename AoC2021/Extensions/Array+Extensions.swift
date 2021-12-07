//
//  Array+Extensions.swift
//  AoC2021
//
//  Created by Martin Václavík on 07.12.2021.
//

import Foundation

extension Array where Element == Bool {
    func toggledBits() -> [Bool] {
        var retval: [Bool] = []
        self.forEach { bit in
            retval.append(!bit)
        }
        return retval
    }
    
    func asBit() -> String {
        var retval: String = ""
        self.forEach { bit in
            retval.append(bit ? "1" : "0")
        }
        return retval
    }
}
