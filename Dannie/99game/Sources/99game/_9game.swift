import Foundation

@main
struct _9game {
    static func main() {
        let args = CommandLine.arguments

        var games = 100
        var playerTypes = ["random", "greedy"]
        var visualize = true

        func printHelp() {
            print("""
            99 Card Game Simulator

            Usage: 99game [options]

            Rules: Standard 99 — running total starts at 0; play cards without exceeding 99.
            A=1/11, 4=reverse, 9=pass, 10=±10, J/Q=+10, K=99. No legal move = eliminated.
            Last player standing wins the round.

            Options:
              -g, --games <count>       Number of games to simulate (default: 100)
              -p, --players <types>     Comma-separated player types, 2–4 entries
                                        Types: random, greedy (default: random,greedy)
              -v, --visualize           Print each turn as games are played
              -h, --help                Show this help menu
            """)
        }

        var i = 1
        while i < args.count {
            let arg = args[i]
            switch arg {
            case "-h", "--help":
                printHelp()
                return
            case "-v", "--visualize":
                visualize = true
                i += 1
            case "-g", "--games":
                if i + 1 < args.count, let val = Int(args[i + 1]), val > 0 {
                    games = val
                    i += 2
                } else {
                    print("Error: -g/--games requires a positive integer value.")
                    printHelp()
                    exit(1)
                }
            case "-p", "--players":
                if i + 1 < args.count {
                    let types = args[i + 1].split(separator: ",").map {
                        String($0).trimmingCharacters(in: .whitespaces).lowercased()
                    }
                    guard types.count >= 2, types.count <= 4 else {
                        print("Error: --players requires 2–4 comma-separated player types.")
                        printHelp()
                        exit(1)
                    }
                    let valid = Set(["random", "greedy"])
                    for type in types where !valid.contains(type) {
                        print("Error: Invalid player type '\(type)'. Must be one of: random, greedy.")
                        printHelp()
                        exit(1)
                    }
                    playerTypes = types
                    i += 2
                } else {
                    print("Error: -p/--players requires a comma-separated list of types.")
                    printHelp()
                    exit(1)
                }
            default:
                print("Error: Unknown argument '\(arg)'.")
                printHelp()
                exit(1)
            }
        }

        let players = PlayerFactory.createAll(types: playerTypes)
        let runner = GameRunner(players: players, totalGames: games, visualize: visualize)
        runner.run()
    }
}
