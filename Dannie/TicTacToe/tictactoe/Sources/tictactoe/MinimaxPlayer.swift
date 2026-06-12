import Foundation

public final class MinimaxPlayer: TicTacToePlayer, @unchecked Sendable {
    public let name: String
    public var piece: BoardPiece
    private var board: Board
    private let lock = NSLock()
    
    public init(name: String, piece: BoardPiece) {
        self.name = name
        self.piece = piece
        self.board = Board()
    }
    
    public func updateBoard(_ board: Board) {
        lock.lock()
        defer { lock.unlock() }
        self.board = board
    }
    
    public func requestMove() -> (row: Int, col: Int) {
        lock.lock()
        let currentBoard = board
        lock.unlock()
        
        return findBestMove(board: currentBoard)
    }
    
    private func findBestMove(board: Board) -> (row: Int, col: Int) {
        let moves = board.availableMoves()
        guard !moves.isEmpty else { return (0, 0) }
        
        // Optimization for empty board: take the center (1, 1) for optimal first move
        if moves.count == 9 {
            return (1, 1)
        }
        
        let opponentPiece = piece.opposite
        var bestScore = Int.min
        var bestMoves: [(row: Int, col: Int)] = []
        
        for move in moves {
            var nextBoard = board
            _ = nextBoard.makeMove(row: move.row, col: move.col, piece: piece)
            let score = minimax(board: nextBoard, depth: 0, alpha: Int.min, beta: Int.max, isMaximizing: false, maxPlayer: piece, minPlayer: opponentPiece)
            if score > bestScore {
                bestScore = score
                bestMoves = [move]
            } else if score == bestScore {
                bestMoves.append(move)
            }
        }
        
        return bestMoves.randomElement() ?? moves[0]
    }
    
    private func minimax(board: Board, depth: Int, alpha: Int, beta: Int, isMaximizing: Bool, maxPlayer: BoardPiece, minPlayer: BoardPiece) -> Int {
        if let winner = board.winner() {
            if winner == maxPlayer {
                return 10 - depth
            } else if winner == minPlayer {
                return depth - 10
            }
        }
        if board.isFull() {
            return 0
        }
        
        var alphaVar = alpha
        var betaVar = beta
        
        if isMaximizing {
            var bestScore = Int.min
            for move in board.availableMoves() {
                var nextBoard = board
                _ = nextBoard.makeMove(row: move.row, col: move.col, piece: maxPlayer)
                let score = minimax(board: nextBoard, depth: depth + 1, alpha: alphaVar, beta: betaVar, isMaximizing: false, maxPlayer: maxPlayer, minPlayer: minPlayer)
                bestScore = max(bestScore, score)
                alphaVar = max(alphaVar, bestScore)
                if betaVar <= alphaVar {
                    break
                }
            }
            return bestScore
        } else {
            var bestScore = Int.max
            for move in board.availableMoves() {
                var nextBoard = board
                _ = nextBoard.makeMove(row: move.row, col: move.col, piece: minPlayer)
                let score = minimax(board: nextBoard, depth: depth + 1, alpha: alphaVar, beta: betaVar, isMaximizing: true, maxPlayer: maxPlayer, minPlayer: minPlayer)
                bestScore = min(bestScore, score)
                betaVar = min(betaVar, bestScore)
                if betaVar <= alphaVar {
                    break
                }
            }
            return bestScore
        }
    }
}
