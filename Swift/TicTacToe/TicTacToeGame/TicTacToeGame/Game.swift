import Foundation

enum PlayerError: Error {
    case playerNotFound(name: String)
}

class Game {
    
    init() {
    }
    
    public func runGame(player1: String, player2: String, count: Int) throws {
        var player1Wins = 0
        var player2Wins = 0
        var draws = 0
        
        print("Running \(count) pairs of games for player1: \(player1) vs player2: \(player2)")
        
        for i in 0..<count {
            print("  Game pair #\(i)")
            let p1g1 = try player(name: player1)
            let p2g1 = try player(name: player2)
            print("    Player 1 is x, Player 2 is o")
            let result1 = runSingleGame(xPlayer: p1g1, oPlayer: p2g1)
            switch result1 {
            case .draw:
                print("      draw")
                draws+=1
            case .xWins:
                print("      Player 1 (x) wins")
                player1Wins+=1
            case .oWins:
                print("      Player 2 (o) wins")
                player2Wins+=1
            case .playing:
                // Error.
                break
            }
            
            let p1g2 = try player(name: player1)
            let p2g2 = try player(name: player2)
            print("    Player 2 is x, Player 1 is o")
            let result2 = runSingleGame(xPlayer: p2g2, oPlayer: p1g2)
            switch result2 {
            case .draw:
                print("      draw")
                draws+=1
            case .xWins:
                print("      Player 2 (x) wins")
                player2Wins+=1
            case .oWins:
                print("      Player 1 (o) wins")
                player1Wins+=1
            case .playing:
                // Error.
                break
            }
        }
        print("Game results:")
        print("Player 1 wins: \(player1Wins)")
        print("Player 2 wins: \(player2Wins)")
        print("Draws: \(draws)")
    }
    
    private func player(name: String) throws -> Player {
        switch (name) {
        case "RandomPlayer":
            return RandomPlayer()
        case "BlockingThenRandomPlayer":
            return BlockingThenRandomPlayer()
        default:
            throw PlayerError.playerNotFound(name: name)
        }
    }
    
    private func runSingleGame(xPlayer: Player, oPlayer: Player) -> GameState {
        let gameBoard = GameBoardImpl(xSize: 3, ySize: 3)
        // Player1 is x, Player2 is o.
        var currentTurn: Value = .x
        
        gameBoard.printBoard()
        while gameBoard.state == .playing {
            let move = currentTurn == .x ? xPlayer.makeMove(gameBoard: gameBoard, playerValue: .x) :
            oPlayer.makeMove(gameBoard: gameBoard, playerValue: .o)
            let moveResult = gameBoard.setValue(x: move.x, y: move.y, value: currentTurn)
            guard moveResult else {
                // Player made an illegal move, end the game.
                return currentTurn == .x ? .oWins : .xWins
            }
            currentTurn = currentTurn == .x ? .o : .x
            gameBoard.printBoard()
        }
        
        return gameBoard.state
    }
    
}
