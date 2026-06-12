import Foundation

public final class GameRunner: @unchecked Sendable {
    private let player1: TicTacToePlayer
    private let player2: TicTacToePlayer
    private let totalGames: Int
    private let visualize: Bool
    
    private var p1Wins = 0
    private var p2Wins = 0
    private var draws = 0
    
    public init(player1: TicTacToePlayer, player2: TicTacToePlayer, totalGames: Int, visualize: Bool = false) {
        self.player1 = player1
        self.player2 = player2
        self.totalGames = totalGames
        self.visualize = visualize
    }
    
    public func run() {
        print("Starting Tic Tac Toe simulation: \(player1.name) vs \(player2.name) for \(totalGames) games.\n")
        
        let isHumanPlaying = (player1 is HumanPlayer) || (player2 is HumanPlayer)
        // Verbose/visualization mode is on if explicitly requested or if a human player is active
        let verbose = visualize || isHumanPlaying
        
        for gameIndex in 1...totalGames {
            print("========================================")
            print("Game \(gameIndex) of \(totalGames)")
            print("========================================")
            
            var board = Board()
            
            // Alternate who goes first.
            // Game 1: Player 1 is X, Player 2 is O. (Player 1 goes first)
            // Game 2: Player 2 is X, Player 1 is O. (Player 2 goes first)
            let p1Piece: BoardPiece
            let p2Piece: BoardPiece
            let firstPlayerName: String
            
            if gameIndex % 2 == 1 {
                p1Piece = .x
                p2Piece = .o
                firstPlayerName = player1.name
            } else {
                p1Piece = .o
                p2Piece = .x
                firstPlayerName = player2.name
            }
            
            player1.piece = p1Piece
            player2.piece = p2Piece
            
            player1.updateBoard(board)
            player2.updateBoard(board)
            
            print("\(player1.name) is playing as \(p1Piece.rawValue)")
            print("\(player2.name) is playing as \(p2Piece.rawValue)")
            print("\(firstPlayerName) starts (X goes first)\n")
            
            if verbose {
                print("Initial Board:")
                print(board.render())
            }
            
            // X always goes first
            var currentPiece = BoardPiece.x
            
            while !board.isGameOver() {
                let activePlayer: TicTacToePlayer = (player1.piece == currentPiece) ? player1 : player2
                
                if verbose {
                    print("\(activePlayer.name)'s turn (\(currentPiece.rawValue)):")
                }
                
                let move = activePlayer.requestMove()
                
                // Validate move
                if !board.isValidMove(row: move.row, col: move.col) {
                    if verbose {
                        print("Warning: \(activePlayer.name) attempted invalid move at (\(move.row), \(move.col)). Selecting a random valid move instead.")
                    }
                    let available = board.availableMoves()
                    if let fallbackMove = available.randomElement() {
                        _ = board.makeMove(row: fallbackMove.row, col: fallbackMove.col, piece: currentPiece)
                    }
                } else {
                    _ = board.makeMove(row: move.row, col: move.col, piece: currentPiece)
                }
                
                // Update both players with the new board state
                player1.updateBoard(board)
                player2.updateBoard(board)
                
                if verbose {
                    print(board.render())
                }
                
                // Switch turn
                currentPiece = currentPiece.opposite
            }
            
            // Game over. Check result
            if let winnerPiece = board.winner() {
                if player1.piece == winnerPiece {
                    p1Wins += 1
                    print("🏆 Game \(gameIndex) Winner: \(player1.name) (\(winnerPiece.rawValue))")
                } else {
                    p2Wins += 1
                    print("🏆 Game \(gameIndex) Winner: \(player2.name) (\(winnerPiece.rawValue))")
                }
            } else {
                draws += 1
                print("🤝 Game \(gameIndex) ended in a Draw!")
            }
            
            // Print current score progress
            print("\nScore after Game \(gameIndex):")
            print("  \(player1.name): \(p1Wins) wins")
            print("  \(player2.name): \(p2Wins) wins")
            print("  Draws: \(draws)")
            print("----------------------------------------\n")
        }
        
        // Final score summary
        print("========================================")
        print("             FINAL SCORES               ")
        print("========================================")
        print("\(player1.name) Wins: \(p1Wins) (\(percentage(p1Wins, total: totalGames))%)")
        print("\(player2.name) Wins: \(p2Wins) (\(percentage(p2Wins, total: totalGames))%)")
        print("Draws: \(draws) (\(percentage(draws, total: totalGames))%)")
        print("========================================\n")
    }
    
    private func percentage(_ count: Int, total: Int) -> String {
        guard total > 0 else { return "0.0" }
        let pct = (Double(count) / Double(total)) * 100.0
        return String(format: "%.1f", pct)
    }
}
