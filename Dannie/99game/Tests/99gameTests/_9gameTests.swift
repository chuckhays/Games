import Testing
@testable import _9game

// MARK: - GameRules tests

@Test func aceResultingTotals() {
    let ace = Card(rank: .ace, suit: .hearts)
    #expect(GameRules.resultingTotal(current: 80, card: ace, aceValue: 1) == 81)
    #expect(GameRules.resultingTotal(current: 80, card: ace, aceValue: 11) == 91)
    #expect(GameRules.resultingTotal(current: 90, card: ace, aceValue: 11) == 101)
    #expect(!GameRules.isValidMove(Move(handIndex: 0, aceValue: 11), hand: [ace], total: 90))
}

@Test func tenResultingTotals() {
    let ten = Card(rank: .ten, suit: .clubs)
    #expect(GameRules.resultingTotal(current: 50, card: ten, tenDelta: 10) == 60)
    #expect(GameRules.resultingTotal(current: 50, card: ten, tenDelta: -10) == 40)
    #expect(GameRules.resultingTotal(current: 95, card: ten, tenDelta: 10) == 105)
    #expect(!GameRules.isValidMove(Move(handIndex: 0, tenDelta: 10), hand: [ten], total: 95))
}

@Test func kingSetsTotalTo99() {
    let king = Card(rank: .king, suit: .spades)
    #expect(GameRules.resultingTotal(current: 10, card: king) == 99)
    #expect(GameRules.resultingTotal(current: 99, card: king) == 99)
}

@Test func faceCardsAndNumberCards() {
    #expect(GameRules.resultingTotal(current: 20, card: Card(rank: .seven, suit: .hearts)) == 27)
    #expect(GameRules.resultingTotal(current: 20, card: Card(rank: .jack, suit: .hearts)) == 30)
    #expect(GameRules.resultingTotal(current: 20, card: Card(rank: .queen, suit: .hearts)) == 30)
    #expect(GameRules.resultingTotal(current: 20, card: Card(rank: .four, suit: .hearts)) == 20)
    #expect(GameRules.resultingTotal(current: 20, card: Card(rank: .nine, suit: .hearts)) == 20)
}

@Test func legalMovesExcludesBustingPlays() {
    let hand = [
        Card(rank: .king, suit: .hearts),
        Card(rank: .five, suit: .clubs),
        Card(rank: .nine, suit: .diamonds),
    ]
    let moves = GameRules.legalMoves(hand: hand, total: 95)
    #expect(moves.contains(where: { hand[$0.handIndex].rank == .nine }))
    #expect(!moves.contains(where: { hand[$0.handIndex].rank == .five }))
    #expect(moves.contains(where: { hand[$0.handIndex].rank == .king }))
}

@Test func legalMovesAceChoices() {
    let hand = [Card(rank: .ace, suit: .spades)]
    let moves = GameRules.legalMoves(hand: hand, total: 88)
    #expect(moves.count == 2)
    #expect(moves.contains(where: { $0.aceValue == 1 }))
    #expect(moves.contains(where: { $0.aceValue == 11 }))
}

@Test func noLegalMovesWhenAllBust() {
    let hand = [
        Card(rank: .five, suit: .hearts),
        Card(rank: .six, suit: .clubs),
    ]
    #expect(GameRules.hasLegalMove(hand: hand, total: 95) == false)
}

@Test func fourReversesDirection() {
    #expect(GameRules.reversesDirection(for: Card(rank: .four, suit: .hearts)) == true)
    #expect(GameRules.reversesDirection(for: Card(rank: .five, suit: .hearts)) == false)
}

// MARK: - GameEngine tests

@Test func twoPlayerRoundProducesWinner() {
    let p0 = RandomPlayer(name: "P0")
    let p1 = RandomPlayer(name: "P1")
    p0.seatIndex = 0
    p1.seatIndex = 1

    let engine = GameEngine(players: [p0, p1])
    let winner = engine.runRound(startingSeat: 0)
    #expect(winner == 0 || winner == 1)
}

@Test func eliminationWhenNoLegalMoves() {
    let trappedHand = [
        Card(rank: .five, suit: .hearts),
        Card(rank: .six, suit: .clubs),
    ]
    let survivorHand = [
        Card(rank: .nine, suit: .diamonds),
        Card(rank: .four, suit: .spades),
    ]

    #expect(GameRules.hasLegalMove(hand: trappedHand, total: 95) == false)
    #expect(GameRules.hasLegalMove(hand: survivorHand, total: 95) == true)
}

@Test func fourPlayerRoundProducesSingleWinner() {
    let players: [NinetyNinePlayer] = (0..<4).map { i in
        let p = RandomPlayer(name: "P\(i)")
        p.seatIndex = i
        return p
    }
    let engine = GameEngine(players: players)
    let winner = engine.runRound(startingSeat: 0)
    #expect((0..<4).contains(winner))
}

// MARK: - GameRunner tests

@Test func runnerScoresSumToGameCount() {
    let players = PlayerFactory.createAll(types: ["random", "greedy"])
    let runner = GameRunner(players: players, totalGames: 20, visualize: false)
    runner.run()
    let totalWins = runner.winCounts.reduce(0, +)
    #expect(totalWins == 20)
}

@Test func runnerSupportsFourPlayers() {
    let players = PlayerFactory.createAll(types: ["random", "greedy", "random", "greedy"])
    #expect(players.count == 4)
    let runner = GameRunner(players: players, totalGames: 8, visualize: false)
    runner.run()
    #expect(runner.winCounts.reduce(0, +) == 8)
}

@Test func playerFactoryCreatesNamedPlayers() {
    let players = PlayerFactory.createAll(types: ["random", "greedy", "random"])
    #expect(players[0].name == "Random 1")
    #expect(players[1].name == "Greedy 2")
    #expect(players[2].name == "Random 3")
}

@Test func deckHas52Cards() {
    let deck = Deck.standardShuffled()
    #expect(deck.count == 52)
    let unique = Set(deck)
    #expect(unique.count == 52)
}
