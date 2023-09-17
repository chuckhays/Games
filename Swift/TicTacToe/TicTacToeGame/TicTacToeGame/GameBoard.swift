import Foundation

enum Value {
    case x, o, empty, invalid
}

enum GameState {
    case playing, xWins, oWins, draw
}

protocol GameBoard {
    func valueInSpace(x: Int, y: Int) -> Value
    var xSize: Int { get }
    var ySize: Int { get }
    var state: GameState { get }
}

class GameBoardImpl: GameBoard {
    
    public let xSize: Int
    public let ySize: Int
    private var values: [[Value]]
    init(xSize: Int, ySize: Int) {
        self.xSize = xSize
        self.ySize = ySize
        values = Array(repeating: Array(repeating: .empty, count: ySize), count:xSize)
    }
    
    public var state: GameState {
        // Check for winners.
        // Check columns.
        for x in 0..<xSize {
            let firstValue = values[x][0]
            if firstValue == .x || firstValue == .o {
                var matches = true
                for y in 1..<ySize {
                    if firstValue != values[x][y] {
                        matches = false
                        break
                    }
                }
                if matches {
                    return firstValue == .x ? .xWins : .oWins
                }
            }
        }
        // Check rows.
        for y in 0..<ySize {
            let firstValue = values[0][y]
            if firstValue == .x || firstValue == .o {
                var matches = true
                for x in 1..<xSize {
                    if firstValue != values[x][y] {
                        matches = false
                        break
                    }
                }
                if matches {
                    return firstValue == .x ? .xWins : .oWins
                }
            }
        }
        // Check diagonals (only applies in square games).
        if xSize == ySize {
            var firstValue = values[0][0]
            if firstValue == .x || firstValue == .o {
                var matches = true
                for i in 1..<xSize {
                    if firstValue != values[i][i] {
                        matches = false
                        break
                    }
                }
                if matches {
                    return firstValue == .x ? .xWins : .oWins
                }
            }
            firstValue = values[xSize - 1][0]
            if firstValue == .x || firstValue == .o {
                var matches = true
                for i in 1..<xSize {
                    if firstValue != values[xSize - 1 - i][i] {
                        matches = false
                        break
                    }
                }
                if matches {
                    return firstValue == .x ? .xWins : .oWins
                }
            }
        }
        
        // Check for draw.
        for x in 0..<xSize {
            for y in 0..<ySize {
                guard values[x][y] != .empty else {
                    // Found an empty spot.
                    return .playing
                }
            }
        }
        return .draw
    }
    
    public func valueInSpace(x: Int, y: Int) -> Value {
        guard x >= 0 && x < xSize && y >= 0 && y < ySize  else {
            return .invalid
        }
        return values[x][y]
    }
    
    public func setValue(x: Int, y:Int, value:Value) -> Bool {
        // Check if x/y are valid.
        guard x >= 0 && x < xSize && y >= 0 && y < ySize  else {
            return false
        }
        // Check if spot is empty.
        guard values[x][y] == .empty else {
            return false
        }
        values[x][y] = value
        return true
    }
    
    public func printBoard() {
        let width = xSize * 2 + 1
        func printSeparator() {
            for _ in 0..<width - 1 {
                print("-", terminator: "")
            }
            print("-")
        }
        func printRow(y: Int) {
            for x in 0..<xSize {
                let value = values[x][y]
                print("|", terminator: "")
                switch value {
                case .x:
                    print("x", terminator: "")
                case .o:
                    print("o", terminator: "")
                case .empty:
                    print(" ", terminator: "")
                case .invalid:
                    print("?", terminator: "")
                }
            }
            print("|")
            printSeparator()
        }
        printSeparator()
        for y in 0..<ySize {
            printRow(y: y)
        }
    }
    
}
