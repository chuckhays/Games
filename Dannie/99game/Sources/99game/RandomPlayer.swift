import Foundation

public final class RandomPlayer: NinetyNinePlayerBase {
    public override func requestMove() -> Move {
        legalMoves().randomElement()!
    }
}
