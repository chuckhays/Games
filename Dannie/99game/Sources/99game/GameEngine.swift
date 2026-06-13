import Foundation

public struct GameEngine {
    public let state: GameState
    private let players: [NinetyNinePlayer]
    private let visualize: Bool

    public init(players: [NinetyNinePlayer], visualize: Bool = false) {
        self.players = players
        self.visualize = visualize
        self.state = GameState()
    }

    /// Runs one round and returns the winning seat index.
    public func runRound(startingSeat: Int) -> Int {
        resetForNewRound(startingSeat: startingSeat)

        for player in players {
            player.beginNewGame(state: state, seatIndex: player.seatIndex)
        }

        if visualize {
            print("Starting total: \(state.total)")
            for (index, player) in players.enumerated() where !state.eliminated[index] {
                print("  \(player.name): \(state.hands[index].map(\.displayName).joined(separator: ", "))")
            }
            print("\(players[startingSeat].name) goes first\n")
        }

        while activePlayerCount() > 1 {
            let seat = state.activeSeatIndex

            if state.eliminated[seat] {
                advanceTurn()
                continue
            }

            state.refreshView(for: seat)

            let hand = state.hands[seat]
            if !GameRules.hasLegalMove(hand: hand, total: state.total) {
                eliminate(seat: seat, reason: "no legal moves")
                if activePlayerCount() <= 1 { break }
                advanceTurn()
                continue
            }

            let player = players[seat]
            var move = player.requestMove()

            if !GameRules.isValidMove(move, hand: hand, total: state.total) {
                if visualize {
                    print("Warning: \(player.name) attempted invalid move. Using fallback.")
                }
                move = state.legalMoves().first!
            }

            let card = hand[move.handIndex]
            let previousTotal = state.total
            applyMove(move, at: seat)

            if visualize {
                let description = GameRules.describeMove(move, hand: hand)
                print("\(player.name) plays \(description): \(previousTotal) → \(state.total)")
            }

            if GameRules.reversesDirection(for: card) {
                state.reversePlayDirection()
                if visualize {
                    print("  Direction reversed")
                }
            }

            drawCard(for: seat)

            if activePlayerCount() <= 1 { break }
            advanceTurn()
        }

        return winnerSeat()!
    }

    private func resetForNewRound(startingSeat: Int) {
        var deck = Deck.standardShuffled()
        let playerCount = players.count

        state.hands = Array(repeating: [], count: playerCount)
        for seat in 0..<playerCount {
            state.hands[seat] = Array(deck.prefix(3))
            deck.removeFirst(3)
        }

        state.drawPile = deck
        state.discardPile = []
        state.resetRound(startingSeat: startingSeat, names: players.map(\.name))
        state.refreshView(for: startingSeat)
    }

    private func applyMove(_ move: Move, at seat: Int) {
        let card = state.hands[seat][move.handIndex]
        state.hands[seat].remove(at: move.handIndex)

        if let newTotal = GameRules.resultingTotal(
            current: state.total,
            card: card,
            aceValue: move.aceValue,
            tenDelta: move.tenDelta
        ) {
            state.setTotal(newTotal)
        }

        state.discardPile.append(card)
    }

    private func drawCard(for seat: Int) {
        if state.drawPile.isEmpty {
            guard !state.discardPile.isEmpty else { return }
            let top = state.discardPile.removeLast()
            state.drawPile = state.discardPile
            state.discardPile = [top]
            state.drawPile.shuffle()
        }

        if !state.drawPile.isEmpty {
            let drawn = state.drawPile.removeFirst()
            state.hands[seat].append(drawn)
        }
    }

    private func eliminate(seat: Int, reason: String) {
        state.eliminateSeat(seat)
        if visualize {
            print("\(players[seat].name) eliminated (\(reason))")
        }
    }

    private func advanceTurn() {
        let count = players.count
        var next = state.activeSeatIndex
        repeat {
            next = (next + state.playDirection + count) % count
        } while state.eliminated[next] && activePlayerCount() > 0 && next != state.activeSeatIndex
        state.setActiveSeat(next)
    }

    private func activePlayerCount() -> Int {
        state.eliminated.filter { !$0 }.count
    }

    private func winnerSeat() -> Int? {
        state.eliminated.firstIndex(where: { !$0 })
    }
}
