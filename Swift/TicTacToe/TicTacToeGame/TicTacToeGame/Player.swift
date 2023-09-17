import Foundation

protocol Player {
    
    func makeMove(gameBoard: GameBoard, playerValue: Value) -> (x: Int, y: Int)
    
}
