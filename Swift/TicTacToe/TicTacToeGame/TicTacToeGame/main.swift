import ArgumentParser
import Foundation

struct TicTacToeGame: ParsableCommand {
    @Option(name: [.long])
    var player1: String
    
    @Option(name: [.long])
    var player2: String
    
    @Option(name: [.short, .long])
    var count: Int
    
    mutating func run() throws {
        let game = Game()
        game.runGame(player1: player1, player2: player2, count: count)
    }
}

TicTacToeGame.main()

