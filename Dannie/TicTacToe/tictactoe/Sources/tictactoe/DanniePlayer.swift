import Foundation

public final class DanniePlayer: TicTacToePlayerBase {
    
    public override func requestMove() -> (row: Int, col: Int) {
        let available = board.availableMoves()
        
        guard !available.isEmpty else {
            return (0, 0)
        }
        return available.randomElement()!
    }
}
