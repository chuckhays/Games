import Foundation

public final class RandomPlayer: TicTacToePlayer, @unchecked Sendable {
    public let name: String
    public var piece: BoardPiece
    private var board: Board
    private let lock = NSLock()
    
    public init(name: String, piece: BoardPiece) {
        self.name = name
        self.piece = piece
        self.board = Board()
    }
    
    public func getBoard() -> Board {
        lock.lock()
        defer { lock.unlock() }
        return board
    }
    
    public func updateBoard(_ board: Board) {
        lock.lock()
        defer { lock.unlock() }
        self.board = board
    }
    
    public func requestMove() -> (row: Int, col: Int) {
        lock.lock()
        let available = board.availableMoves()
        lock.unlock()
        
        guard !available.isEmpty else {
            return (0, 0)
        }
        return available.randomElement()!
    }
}
