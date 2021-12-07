//
//  Models.swift
//  AoC2021
//
//  Created by Martin Václavík on 07.12.2021.
//

import Foundation

struct Day2Command {
    let direction: Direction
    let distance: Int
    
    static func parse(from text: String) throws -> Day2Command {
        let words = text.components(separatedBy: .whitespaces)
        guard let direction = Direction(rawValue: words[0]),
              let distance = Int(words[1])
        else {
            throw CommandError.parsingFailed
        }
        return Day2Command(direction: direction, distance: distance)
    }
    enum CommandError: Error {
        case parsingFailed
    }
    enum Direction: String {
        case none, forward, down, up
    }
}
