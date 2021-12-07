//
//  Models.swift
//  AoC2021
//
//  Created by Martin Václavík on 07.12.2021.
//

import Foundation

//MARK: - Day2
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

//MARK: - Day4
class Bingo{
    var boards: [BingoBoard]
    
    init(with boards: [BingoBoard]) {
        self.boards = boards
    }
    
    func call(_ number: Int) -> (BingoBoard?, Int) {
        var winner: BingoBoard?
        var sum = 0
        boards.forEach { board in
            board.findAndMark(number)
            let boardResult = board.isWinner()
            if boardResult.0 {
                winner = board
                sum = boardResult.1
            }
        }
        print(winner != nil ? "Winner!" : "No winner")
        return (winner, sum)
    }
}

class BingoBoard {
    var numberRows: [[BingoNumber]]
    
    init(input: [[Int]]) {
        numberRows = []
        input.forEach { sourceRow in
            var row: [BingoNumber] = []
            sourceRow.forEach { number in
                row.append(BingoNumber(number: number))
            }
            if row.isEmpty == false {
                numberRows.append(row)
            }
        }
    }
    func findAndMark(_ calledNumber: Int){
        numberRows.forEach({ row in
            row.forEach({ number in
                if number.number == calledNumber {
                    number.mark()
                }
            })
        })
    }
    func isWinner() -> (Bool, Int) {
        let rowResult = checkRows()
        let columnResult = checkColumns()
        if rowResult.0 {
            return rowResult
        }
        if columnResult.0 {
            return rowResult
        }
        return (false, 0)
    }
    
    func checkRows() -> (Bool, Int) {
        for row in numberRows {
            if row.allSatisfy({ $0.marked }) {
                return (true, sumUnmarked())
            }
        }
        return (false, 0)
    }
    func checkColumns() -> (Bool, Int) {
        for i in 0..<5 {
            for j in 0..<5 {
                if numberRows[i][j].marked == false {
                    continue
                }
                return (true, sumUnmarked())
            }
        }
        return (false, 0)
    }
    
    func sumUnmarked() -> Int {
        var sum = 0
        numberRows.forEach { row in
            row.forEach { number in
                if number.marked == false {
                    sum += number.number
                }
            }
        }
        return sum
    }
}

class BingoNumber {
    init(number: Int) {
        self.number = number
        self.marked = false
    }
    
    let number: Int
    var marked: Bool = false
    
    func mark() {
        marked = true
    }
}
