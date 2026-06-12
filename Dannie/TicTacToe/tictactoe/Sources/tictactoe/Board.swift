import Foundation

public enum BoardPiece: String, Codable, CaseIterable, Sendable {
    case x = "X"
    case o = "O"
    case empty = " "
    
    public var opposite: BoardPiece {
        switch self {
        case .x: return .o
        case .o: return .x
        case .empty: return .empty
        }
    }
}

public class Board {
    private(set) public var grid: [[BoardPiece]]
    
    public init() {
        self.grid = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
    }
    
    public init(grid: [[BoardPiece]]) {
        self.grid = grid
    }
    
    public func isValidMove(row: Int, col: Int) -> Bool {
        guard row >= 0 && row < 3 && col >= 0 && col < 3 else {
            return false
        }
        return grid[row][col] == .empty
    }
    
    public func makeMove(row: Int, col: Int, piece: BoardPiece) -> Bool {
        guard isValidMove(row: row, col: col) else {
            return false
        }
        grid[row][col] = piece
        return true
    }
    
    public func availableMoves() -> [(row: Int, col: Int)] {
        var moves: [(row: Int, col: Int)] = []
        for r in 0..<3 {
            for c in 0..<3 {
                if grid[r][c] == .empty {
                    moves.append((row: r, col: c))
                }
            }
        }
        return moves
    }
    
    public func winner() -> BoardPiece? {
        // Check rows
        for r in 0..<3 {
            if grid[r][0] != .empty && grid[r][0] == grid[r][1] && grid[r][1] == grid[r][2] {
                return grid[r][0]
            }
        }
        // Check columns
        for c in 0..<3 {
            if grid[0][c] != .empty && grid[0][c] == grid[1][c] && grid[1][c] == grid[2][c] {
                return grid[0][c]
            }
        }
        // Check diagonals
        if grid[0][0] != .empty && grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2] {
            return grid[0][0]
        }
        if grid[0][2] != .empty && grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0] {
            return grid[0][2]
        }
        
        return nil
    }
    
    public func isFull() -> Bool {
        for r in 0..<3 {
            for c in 0..<3 {
                if grid[r][c] == .empty {
                    return false
                }
            }
        }
        return true
    }
    
    public func isGameOver() -> Bool {
        return winner() != nil || isFull()
    }
    
    public func render() -> String {
        var output = ""
        for r in 0..<3 {
            output += " " + grid[r].map { $0.rawValue }.joined(separator: " | ") + " \n"
            if r < 2 {
                output += "---+---+---\n"
            }
        }
        return output
    }
}
