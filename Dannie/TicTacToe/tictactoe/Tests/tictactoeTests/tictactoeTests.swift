import Testing
@testable import tictactoe

@Suite struct TicTacToeTests {

    @Test func testEmptyBoard() {
        let board = Board()
        #expect(board.winner() == nil)
        #expect(!board.isFull())
        #expect(!board.isGameOver())
        #expect(board.availableMoves().count == 9)
    }

    @Test func testRowWinner() {
        var board = Board()
        _ = board.makeMove(row: 0, col: 0, piece: .x)
        _ = board.makeMove(row: 0, col: 1, piece: .x)
        _ = board.makeMove(row: 0, col: 2, piece: .x)
        
        #expect(board.winner() == .x)
        #expect(board.isGameOver())
    }

    @Test func testColWinner() {
        var board = Board()
        _ = board.makeMove(row: 0, col: 1, piece: .o)
        _ = board.makeMove(row: 1, col: 1, piece: .o)
        _ = board.makeMove(row: 2, col: 1, piece: .o)
        
        #expect(board.winner() == .o)
        #expect(board.isGameOver())
    }

    @Test func testDiagonalWinner() {
        var board = Board()
        _ = board.makeMove(row: 0, col: 0, piece: .x)
        _ = board.makeMove(row: 1, col: 1, piece: .x)
        _ = board.makeMove(row: 2, col: 2, piece: .x)
        
        #expect(board.winner() == .x)
        #expect(board.isGameOver())
    }

    @Test func testDrawGame() {
        // X O X
        // X O O
        // O X X
        var board = Board()
        _ = board.makeMove(row: 0, col: 0, piece: .x)
        _ = board.makeMove(row: 0, col: 1, piece: .o)
        _ = board.makeMove(row: 0, col: 2, piece: .x)
        
        _ = board.makeMove(row: 1, col: 0, piece: .x)
        _ = board.makeMove(row: 1, col: 1, piece: .o)
        _ = board.makeMove(row: 1, col: 2, piece: .o)
        
        _ = board.makeMove(row: 2, col: 0, piece: .o)
        _ = board.makeMove(row: 2, col: 1, piece: .x)
        _ = board.makeMove(row: 2, col: 2, piece: .x)
        
        #expect(board.winner() == nil)
        #expect(board.isFull())
        #expect(board.isGameOver())
    }

    @Test func testInvalidMoves() {
        var board = Board()
        #expect(board.isValidMove(row: 0, col: 0))
        #expect(!board.isValidMove(row: -1, col: 0))
        #expect(!board.isValidMove(row: 3, col: 0))
        #expect(!board.isValidMove(row: 0, col: 3))
        
        _ = board.makeMove(row: 0, col: 0, piece: .x)
        #expect(!board.isValidMove(row: 0, col: 0))
        let madeMove = board.makeMove(row: 0, col: 0, piece: .o)
        #expect(!madeMove)
    }

    @Test func testRandomPlayerOnlyMakesValidMoves() {
        let player = RandomPlayer(name: "Random AI", piece: .x)
        var board = Board()
        
        // Fill 7 cells
        _ = board.makeMove(row: 0, col: 0, piece: .o)
        _ = board.makeMove(row: 0, col: 1, piece: .o)
        _ = board.makeMove(row: 0, col: 2, piece: .o)
        _ = board.makeMove(row: 1, col: 0, piece: .o)
        _ = board.makeMove(row: 1, col: 1, piece: .o)
        _ = board.makeMove(row: 1, col: 2, piece: .o)
        _ = board.makeMove(row: 2, col: 0, piece: .o)
        
        player.updateBoard(board)
        
        let move = player.requestMove()
        #expect(board.isValidMove(row: move.row, col: move.col))
        #expect(move == (2, 1) || move == (2, 2))
    }

    @Test func testMinimaxPlayerWinsImmediately() {
        let player = MinimaxPlayer(name: "Minimax AI", piece: .o)
        var board = Board()
        
        // O has two in a row, should take the win
        _ = board.makeMove(row: 0, col: 0, piece: .o)
        _ = board.makeMove(row: 0, col: 1, piece: .o)
        _ = board.makeMove(row: 1, col: 0, piece: .x)
        _ = board.makeMove(row: 1, col: 1, piece: .x)
        
        player.updateBoard(board)
        let move = player.requestMove()
        #expect(move == (0, 2))
    }

    @Test func testMinimaxPlayerBlocksOpponentWin() {
        let player = MinimaxPlayer(name: "Minimax AI", piece: .o)
        var board = Board()
        
        // X has two in a row, O must block at (0, 2)
        _ = board.makeMove(row: 0, col: 0, piece: .x)
        _ = board.makeMove(row: 0, col: 1, piece: .x)
        _ = board.makeMove(row: 1, col: 0, piece: .o)
        
        player.updateBoard(board)
        let move = player.requestMove()
        #expect(move == (0, 2))
    }

    @Test func testMinimaxVsMinimaxIsAlwaysADraw() {
        let p1 = MinimaxPlayer(name: "Minimax AI 1", piece: .x)
        let p2 = MinimaxPlayer(name: "Minimax AI 2", piece: .o)
        
        let runner = GameRunner(player1: p1, player2: p2, totalGames: 5)
        runner.run()
        
        // Custom verification checking that neither player wins, meaning all 5 games end in draws.
        // We can capture stdout/logs or run it directly and verify.
        // But since we want to verify it in test, let's run the game loops directly here and check their winners.
        for game in 1...5 {
            var board = Board()
            let p1Piece: BoardPiece = (game % 2 == 1) ? .x : .o
            let p2Piece: BoardPiece = (game % 2 == 1) ? .o : .x
            p1.piece = p1Piece
            p2.piece = p2Piece
            
            p1.updateBoard(board)
            p2.updateBoard(board)
            
            var currentPiece = BoardPiece.x
            while !board.isGameOver() {
                let activePlayer = (p1.piece == currentPiece) ? p1 : p2
                let move = activePlayer.requestMove()
                #expect(board.isValidMove(row: move.row, col: move.col))
                _ = board.makeMove(row: move.row, col: move.col, piece: currentPiece)
                p1.updateBoard(board)
                p2.updateBoard(board)
                currentPiece = currentPiece.opposite
            }
            #expect(board.winner() == nil, "Minimax vs Minimax should result in a draw, but winner was \(board.winner()?.rawValue ?? "none")")
        }
    }
}
