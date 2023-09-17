import Foundation

class Game {
    
    init() {
    }
    
    public func runGame(player1: String, player2: String, count: Int) {
        
    }
    
    private func runSingleGame(player1: Player, player2: Player) -> GameState {
        let gameBoard = GameBoardImpl(xSize: 3, ySize: 3)
        // Player1 is x, Player2 is o.
        var currentTurn: Value = .x
        
        while gameBoard.state == .playing {
            let move = currentTurn == .x ? player1.makeMove(gameBoard: gameBoard, playerValue: .x) :
                player2.makeMove(gameBoard: gameBoard, playerValue: .o)
            var moveResult = gameBoard.setValue(x: move.x, y: move.y, value: currentTurn)
            guard moveResult else {
                // Player made an illegal move, end the game.
                return currentTurn == .x ? .oWins : .xWins
            }
            currentTurn = currentTurn == .x ? .o : .x
        }
        
        return gameBoard.state
    }
    
}
