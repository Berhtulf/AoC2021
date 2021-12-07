//
//  Model.swift
//  AoC2021
//
//  Created by Martin Václavík on 03.12.2021.
//

import Foundation

struct AoCSolver {
    var day1Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day1", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    var day2Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day2", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    var day3Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day3", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    var day4Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day4", ofType: "txt")
        return try! String(contentsOfFile: path!).split(omittingEmptySubsequences: false ,whereSeparator: \.isNewline)
    }
    var day5Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day5", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    var day6Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day6", ofType: "txt")
        return try! String(contentsOfFile: path!).split(omittingEmptySubsequences: false ,whereSeparator: \.isNewline)
    }
    var day7Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day7", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    
    func solveDay1() -> [String] {
        let rows = day1Data.compactMap{Int($0)}
        var last = rows.first!
        
        //MARK: Star 1
        var result1 = 0
        for number in rows {
            if last < number {
                result1 += 1
            }
            last = number
        }

        //MARK: Star 2
        var result2 = 0
        var lastSum = rows[..<3].reduce(0, +)
        
        for i in rows.indices.clamped(to: 2..<rows.indices.count) {
            let currSum = rows[i-2...i].reduce(0, +)
            if currSum > lastSum {
                result2 += 1
            }
            lastSum = currSum
        }
        return ["\(result1)", "\(result2)"]
    }
    
    //MARK: - Day 2
    func solveDay2() -> [String] {
        let commands = day2Data.compactMap{String($0)}
        var position = [0,0]
        //MARK: Star 1
        for commandText in commands {
            guard let command = try? Day2Command.parse(from: commandText) else { continue }
            if command.direction == .forward {
                position[0] += command.distance
            }else{
                position[1] += command.direction == .up ? -command.distance : command.distance
            }
        }
        let result1 = position[0] * position[1]
        //MARK: Star 2
        position = [0,0]
        var aim = 0
        
        for commandText in commands {
            guard let command = try? Day2Command.parse(from: commandText) else { continue }
            if command.direction == .forward {
                position[0] += command.distance
                position[1] += aim * command.distance
            }else{
                aim += command.direction == .up ? -command.distance : command.distance
            }
        }
        let result2 = position[0] * position[1]
    
        return ["\(result1)", "\(result2)"]
    }
    
}
