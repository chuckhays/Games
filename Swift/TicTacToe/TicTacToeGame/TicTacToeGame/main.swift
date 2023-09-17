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
        
    }
}

TicTacToeGame.main()

