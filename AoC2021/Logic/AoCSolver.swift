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
        return try! String(contentsOfFile: path!).split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
    }
    var day5Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day5", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    var day6Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day6", ofType: "txt")
        return try! String(contentsOfFile: path!).split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
    }
    var day7Data:[String.SubSequence] {
        let path = Bundle.main.path(forResource: "Day7", ofType: "txt")
        return try! String(contentsOfFile: path!).split(whereSeparator: \.isNewline)
    }
    
    //MARK: - Day 1
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
    
    //MARK: - Day 3
    func solveDay3() -> [String] {
        let diagnostics = day3Data.compactMap{String($0)}
        guard let bitLenght = diagnostics.max(by: {$0.count > $1.count })?.count else { return [] }
        
        //MARK:  Star 1
        var commonBits: [Bool] = []
        for i in 0..<bitLenght {
            var zeroes = 0
            var ones = 0
            for row in diagnostics {
                let result = row[i]
                if result == "0" {
                    zeroes += 1
                }else {
                    ones += 1
                }
            }
            
            commonBits.append(zeroes < ones)
        }
        let gammaString = commonBits.asBit()
        guard let gammaRate = Int(gammaString, radix: 2) else { return [] }
        
        let uncommonBits = commonBits.toggledBits()
        let epsilonRateString = uncommonBits.asBit()
        guard let epsilonRate = Int(epsilonRateString, radix: 2) else { return [] }
        
        let powerConsumption = gammaRate * epsilonRate
        
        //MARK: Star 2
        var criteria: Bool
        var diagCopy = diagnostics
        for i in 0..<bitLenght {
            criteria = diagCopy.getMostCommomBitAt(index: i)
            diagCopy = diagCopy.filter{ $0[i] == (criteria ? "1" : "0")}
            if diagCopy.count == 1 { break }
        }
        guard let oxygen = Int(diagCopy.first ?? "", radix: 2) else { return [] }
        
        diagCopy = diagnostics
        for i in 0..<bitLenght {
            criteria = diagCopy.getMostUncommomBitAt(index: i)
            diagCopy = diagCopy.filter{ $0[i] == (criteria ? "1" : "0")}
            if diagCopy.count == 1 { break }
        }
        guard let co2 = Int(diagCopy.first ?? "", radix: 2) else { return [] }
        
        return ["\(powerConsumption)", "\(oxygen * co2)"]
    }
    
    //MARK: - Day4
    func solveDay4() -> [String] {
        var boards = [BingoBoard]()
        let sourceLines = day4Data.compactMap{String($0)}
        guard let selectedNumbers = sourceLines.first else { return [] }
        let boardSourceLines = sourceLines.dropFirst(2)
        
        var boardSource: [[Int]] = []
        for row in boardSourceLines {
            if row.isEmpty && boardSource.isEmpty == false {
                boards.append(BingoBoard(input: boardSource))
                boardSource = []
                continue
            }
            var boardRow = [Int]()
            for numberText in row.components(separatedBy: .whitespaces) {
                guard let number = Int(numberText) else { continue }
                boardRow.append(number)
            }
            boardSource.append(boardRow)
        }
        let bingo = Bingo(with: boards)
        //MARK: Star 1
        var result1 = ""
        var winner: BingoBoard?
        var sum = 0
        for call in selectedNumbers.components(separatedBy: ","){
            guard let calledNumber = Int(call) else {
                break
            }
            (winner, sum) = bingo.call(calledNumber)
            if winner != nil {
                result1 = "\(sum * calledNumber)"
                break
            }
        }
        
        return ["\(result1)", ""]
    }
}
