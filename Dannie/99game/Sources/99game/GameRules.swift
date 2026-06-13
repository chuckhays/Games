import Foundation

public enum GameRules {
    public static let maxTotal = 99

    /// Computes the total after playing `card` with optional ace/ten choices.
    /// Returns nil if choices are invalid for the card rank.
    public static func resultingTotal(
        current total: Int,
        card: Card,
        aceValue: Int? = nil,
        tenDelta: Int? = nil
    ) -> Int? {
        switch card.rank {
        case .ace:
            guard let aceValue, aceValue == 1 || aceValue == 11 else { return nil }
            return total + aceValue
        case .two: return total + 2
        case .three: return total + 3
        case .four: return total
        case .five: return total + 5
        case .six: return total + 6
        case .seven: return total + 7
        case .eight: return total + 8
        case .nine: return total
        case .ten:
            guard let tenDelta, tenDelta == 10 || tenDelta == -10 else { return nil }
            return total + tenDelta
        case .jack, .queen: return total + 10
        case .king: return maxTotal
        }
    }

    public static func reversesDirection(for card: Card) -> Bool {
        card.rank == .four
    }

    public static func legalMoves(hand: [Card], total: Int) -> [Move] {
        var moves: [Move] = []
        for (index, card) in hand.enumerated() {
            switch card.rank {
            case .ace:
                for value in [1, 11] {
                    if let newTotal = resultingTotal(current: total, card: card, aceValue: value),
                       newTotal <= maxTotal {
                        moves.append(Move(handIndex: index, aceValue: value))
                    }
                }
            case .ten:
                for delta in [10, -10] {
                    if let newTotal = resultingTotal(current: total, card: card, tenDelta: delta),
                       newTotal <= maxTotal {
                        moves.append(Move(handIndex: index, tenDelta: delta))
                    }
                }
            default:
                if let newTotal = resultingTotal(current: total, card: card),
                   newTotal <= maxTotal {
                    moves.append(Move(handIndex: index))
                }
            }
        }
        return moves
    }

    public static func hasLegalMove(hand: [Card], total: Int) -> Bool {
        !legalMoves(hand: hand, total: total).isEmpty
    }

    public static func isValidMove(_ move: Move, hand: [Card], total: Int) -> Bool {
        guard move.handIndex >= 0, move.handIndex < hand.count else { return false }
        let card = hand[move.handIndex]
        guard let newTotal = resultingTotal(
            current: total,
            card: card,
            aceValue: move.aceValue,
            tenDelta: move.tenDelta
        ) else {
            return false
        }
        return newTotal <= maxTotal
    }

    public static func describeMove(_ move: Move, hand: [Card]) -> String {
        let card = hand[move.handIndex]
        var detail = card.displayName
        if card.rank == .ace, let aceValue = move.aceValue {
            detail += " (+\(aceValue))"
        } else if card.rank == .ten, let tenDelta = move.tenDelta {
            detail += " (\(tenDelta >= 0 ? "+" : "")\(tenDelta))"
        } else if card.rank == .four {
            detail += " (reverse)"
        } else if card.rank == .nine {
            detail += " (pass)"
        } else if card.rank == .king {
            detail += " (→99)"
        }
        return detail
    }
}
