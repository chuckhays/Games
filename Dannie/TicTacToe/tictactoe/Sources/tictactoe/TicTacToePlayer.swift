import Foundation

public protocol TicTacToePlayer: AnyObject {
    var name: String { get }
    var piece: BoardPiece { get }

    func beginNewgame(board: Board, piece: BoardPiece)
    
    // Method called on the player to request their next move
    func requestMove() -> (row: Int, col: Int)
}

public class TicTacToePlayerBase: TicTacToePlayer {
    public let name: String
    public var piece: BoardPiece
    private var currentBoard: Board?

    public var board: Board {
        guard let board = currentBoard else {
            fatalError("Player \(name) has not been initialized with a board. Call beginNewgame() first.")
        }
        return board
    }
    
    public init(name: String) {
        self.name = name
        self.piece = .empty
        self.currentBoard = nil
    }

    final public func beginNewgame(board: Board, piece: BoardPiece) {
        self.currentBoard = board
        self.piece = piece
    }
    
    public func requestMove() -> (row: Int, col: Int) {
        fatalError("Subclasses must override requestMove()")
    }
}
