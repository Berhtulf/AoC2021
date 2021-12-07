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

extension Array where Element == String {
    func getMostCommomBitAt(index: Int) -> Bool {
        var zeroes = 0
        var ones = 0
        
        for row in self {
            let result = row[index]
            if result == "0" {
                zeroes += 1
            }else {
                ones += 1
            }
        }
        
        return ones >= zeroes
    }
    
    func getMostUncommomBitAt(index: Int) -> Bool {
        return !getMostCommomBitAt(index: index)
    }
}
