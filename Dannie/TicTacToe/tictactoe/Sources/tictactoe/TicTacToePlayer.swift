import Foundation

public protocol TicTacToePlayer: AnyObject, Sendable {
    var name: String { get }
    var piece: BoardPiece { get set }
    
    // Methods to access game board state
    func updateBoard(_ board: Board)
    
    // Method called on the player to request their next move
    func requestMove() -> (row: Int, col: Int)
}
