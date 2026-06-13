import Foundation

public enum Suit: String, CaseIterable, Sendable {
    case clubs, diamonds, hearts, spades

    public var symbol: String {
        switch self {
        case .clubs: return "♣"
        case .diamonds: return "♦"
        case .hearts: return "♥"
        case .spades: return "♠"
        }
    }
}

public enum Rank: Int, CaseIterable, Sendable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    public var label: String {
        switch self {
        case .ace: return "A"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        default: return "\(rawValue)"
        }
    }
}

public struct Card: Hashable, Sendable {
    public let rank: Rank
    public let suit: Suit

    public init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }

    public var displayName: String {
        "\(rank.label)\(suit.symbol)"
    }
}

public enum Deck {
    public static func standardShuffled() -> [Card] {
        var deck: [Card] = []
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        deck.shuffle()
        return deck
    }
}
