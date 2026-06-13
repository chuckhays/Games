import Foundation

/// Read-only game view exposed to players. Updated in place by `GameEngine` each turn.
public final class GameState: @unchecked Sendable {
    private(set) public var total: Int = 0
    private(set) public var playDirection: Int = 1
    private(set) public var drawPileCount: Int = 0
    private(set) public var discardTop: Card?
    private(set) public var activeSeatIndex: Int = 0
    private(set) public var playerNames: [String] = []
    private(set) public var opponentHandCounts: [Int] = []
    private(set) public var myHand: [Card] = []
    private(set) public var viewingSeatIndex: Int = 0
    private(set) public var eliminatedSeats: Set<Int> = []

    public var isMyTurn: Bool {
        activeSeatIndex == viewingSeatIndex
    }

    public var myHandCount: Int {
        myHand.count
    }

    internal var hands: [[Card]] = []
    internal var drawPile: [Card] = []
    internal var discardPile: [Card] = []
    internal var eliminated: [Bool] = []

    public init() {}

    public func legalMoves() -> [Move] {
        GameRules.legalMoves(hand: myHand, total: total)
    }

    internal func refreshView(for seatIndex: Int) {
        viewingSeatIndex = seatIndex
        myHand = hands[seatIndex]
        opponentHandCounts = hands.enumerated().compactMap { index, hand in
            guard index != seatIndex, !eliminated[index] else { return nil }
            return hand.count
        }
        eliminatedSeats = Set(eliminated.enumerated().compactMap { $1 ? $0 : nil })
        drawPileCount = drawPile.count
        discardTop = discardPile.last
    }

    internal func resetRound(startingSeat: Int, names: [String]) {
        total = 0
        playDirection = 1
        activeSeatIndex = startingSeat
        playerNames = names
        eliminated = Array(repeating: false, count: names.count)
    }

    internal func setTotal(_ value: Int) {
        total = value
    }

    internal func reversePlayDirection() {
        playDirection *= -1
    }

    internal func setActiveSeat(_ seat: Int) {
        activeSeatIndex = seat
    }

    internal func eliminateSeat(_ seat: Int) {
        eliminated[seat] = true
    }
}
