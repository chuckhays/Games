import Foundation

public final class GameRunner: @unchecked Sendable {
    private let players: [NinetyNinePlayer]
    private let totalGames: Int
    private let visualize: Bool

    private var wins: [Int]

    public init(players: [NinetyNinePlayer], totalGames: Int, visualize: Bool = false) {
        precondition(players.count >= 2 && players.count <= 4, "GameRunner requires 2–4 players")
        self.players = players
        self.totalGames = totalGames
        self.visualize = visualize
        self.wins = Array(repeating: 0, count: players.count)
    }

    public func run() {
        let names = players.map(\.name).joined(separator: ", ")
        print("Starting 99 simulation: [\(names)] for \(totalGames) games.\n")

        for gameIndex in 1...totalGames {
            print("========================================")
            print("Game \(gameIndex) of \(totalGames)")
            print("========================================")

            let startingSeat = (gameIndex - 1) % players.count
            print("\(players[startingSeat].name) goes first\n")

            let engine = GameEngine(players: players, visualize: visualize)
            let winnerSeat = engine.runRound(startingSeat: startingSeat)
            wins[winnerSeat] += 1

            print("\nGame \(gameIndex) Winner: \(players[winnerSeat].name)")
            printScore(after: gameIndex)
            print("----------------------------------------\n")
        }

        print("========================================")
        print("             FINAL SCORES               ")
        print("========================================")
        for (index, player) in players.enumerated() {
            print("\(player.name) Wins: \(wins[index]) (\(percentage(wins[index], total: totalGames))%)")
        }
        print("========================================\n")
    }

    public var winCounts: [Int] { wins }

    private func printScore(after gameIndex: Int) {
        print("\nScore after Game \(gameIndex):")
        for (index, player) in players.enumerated() {
            print("  \(player.name): \(wins[index]) win\(wins[index] == 1 ? "" : "s")")
        }
    }

    private func percentage(_ count: Int, total: Int) -> String {
        guard total > 0 else { return "0.0" }
        let pct = (Double(count) / Double(total)) * 100.0
        return String(format: "%.1f", pct)
    }
}

public enum PlayerFactory {
    public static func create(type: String, index: Int) -> NinetyNinePlayer {
        let label = index + 1
        switch type.lowercased() {
        case "random":
            return RandomPlayer(name: "Random \(label)")
        case "greedy":
            return GreedyPlayer(name: "Greedy \(label)")
        default:
            fatalError("Unknown player type: \(type)")
        }
    }

    public static func createAll(types: [String]) -> [NinetyNinePlayer] {
        types.enumerated().map { index, type in
            let player = create(type: type, index: index)
            player.seatIndex = index
            return player
        }
    }
}
