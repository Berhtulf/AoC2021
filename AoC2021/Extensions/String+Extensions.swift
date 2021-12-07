//
//  String+Extensions.swift
//  AoC2021
//
//  Created by Martin Václavík on 07.12.2021.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
}
