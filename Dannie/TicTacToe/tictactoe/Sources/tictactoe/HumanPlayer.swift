import Foundation

public final class HumanPlayer: TicTacToePlayer, @unchecked Sendable {
    public let name: String
    public var piece: BoardPiece
    private var board: Board
    private let lock = NSLock()
    
    public init(name: String, piece: BoardPiece) {
        self.name = name
        self.piece = piece
        self.board = Board()
    }
    
    public func updateBoard(_ board: Board) {
        lock.lock()
        defer { lock.unlock() }
        self.board = board
    }
    
    public func requestMove() -> (row: Int, col: Int) {
        lock.lock()
        let currentBoard = board
        lock.unlock()
        
        print("\(name) (\(piece.rawValue))'s turn. Enter row and column (0-2) separated by a space (e.g., '1 1'): ", terminator: "")
        fflush(stdout)
        
        while let line = readLine() {
            let parts = line.split(separator: " ").compactMap { Int($0) }
            if parts.count == 2 {
                let r = parts[0]
                let c = parts[1]
                if currentBoard.isValidMove(row: r, col: c) {
                    return (r, c)
                }
            }
            print("Invalid move. Please enter row and column (0-2) separated by a space: ", terminator: "")
            fflush(stdout)
        }
        
        // Fallback for EOF/non-interactive run
        let available = currentBoard.availableMoves()
        return available.randomElement() ?? (0, 0)
    }
}
