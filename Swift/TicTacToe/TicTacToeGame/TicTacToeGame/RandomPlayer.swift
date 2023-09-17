import Foundation

class RandomPlayer: Player {
    func makeMove(gameBoard: GameBoard, playerValue: Value) -> (x: Int, y: Int) {
        while true {
            let x = Int.random(in: 0..<gameBoard.xSize)
            let y = Int.random(in: 0..<gameBoard.ySize)
            let value = gameBoard.valueInSpace(x: x, y: y)
            if value == .empty {
                return (x, y)
            }
        }
    }
}
