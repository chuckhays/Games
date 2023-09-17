import Foundation

class Game {
    
    private var gameBoard: GameBoardImpl
    
    init() {
        gameBoard = GameBoardImpl(xSize: 3, ySize: 3)
    }
    
    public func runGame(player1: String, player2: String, count: Int) {
        
    }
    
    private func runSingleGame(player1: Player, player2: Player) {
        // Player1 is x, Player2 is o.
        
    }
    
}
