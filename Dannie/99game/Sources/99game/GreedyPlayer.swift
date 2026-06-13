import Foundation

public final class GreedyPlayer: NinetyNinePlayerBase {
    public override func requestMove() -> Move {
        let moves = legalMoves()
        guard !moves.isEmpty else {
            fatalError("GreedyPlayer asked to move with no legal options")
        }

        // Prefer moves that raise the total toward 99 without busting; break ties with higher totals.
        let scored = moves.map { move -> (Move, Int) in
            let card = myHand[move.handIndex]
            let newTotal = GameRules.resultingTotal(
                current: total,
                card: card,
                aceValue: move.aceValue,
                tenDelta: move.tenDelta
            ) ?? total
            return (move, newTotal)
        }

        let maxTotal = scored.map(\.1).max()!
        let best = scored.filter { $0.1 == maxTotal }.map(\.0)
        return best.randomElement()!
    }
}
