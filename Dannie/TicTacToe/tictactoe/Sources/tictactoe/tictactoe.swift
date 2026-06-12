import Foundation

@main
struct tictactoe {
    static func main() {
        let args = CommandLine.arguments
        
        var games = 10
        var p1Type = "minimax"
        var p2Type = "random"
        
        func printHelp() {
            print("""
            Tic Tac Toe Simulator
            
            Usage: tictactoe [options]
            
            Options:
              -g, --games <count>     Number of games to simulate (default: 10)
              -p1, --player1 <type>   Type of player 1: random, minimax, human (default: minimax)
              -p2, --player2 <type>   Type of player 2: random, minimax, human (default: random)
              -h, --help              Show this help menu
            """)
        }
        
        var i = 1
        while i < args.count {
            let arg = args[i]
            switch arg {
            case "-h", "--help":
                printHelp()
                return
            case "-g", "--games":
                if i + 1 < args.count, let val = Int(args[i+1]), val > 0 {
                    games = val
                    i += 2
                } else {
                    print("Error: -g/--games requires a positive integer value.")
                    printHelp()
                    exit(1)
                }
            case "-p1", "--player1":
                if i + 1 < args.count {
                    let val = args[i+1].lowercased()
                    if ["random", "minimax", "human"].contains(val) {
                        p1Type = val
                        i += 2
                    } else {
                        print("Error: Invalid player type '\(val)' for player 1. Must be one of: random, minimax, human.")
                        printHelp()
                        exit(1)
                    }
                } else {
                    print("Error: -p1/--player1 requires a player type.")
                    printHelp()
                    exit(1)
                }
            case "-p2", "--player2":
                if i + 1 < args.count {
                    let val = args[i+1].lowercased()
                    if ["random", "minimax", "human"].contains(val) {
                        p2Type = val
                        i += 2
                    } else {
                        print("Error: Invalid player type '\(val)' for player 2. Must be one of: random, minimax, human.")
                        printHelp()
                        exit(1)
                    }
                } else {
                    print("Error: -p2/--player2 requires a player type.")
                    printHelp()
                    exit(1)
                }
            default:
                print("Error: Unknown argument '\(arg)'.")
                printHelp()
                exit(1)
            }
        }
        
        // Instantiate player 1
        let p1: TicTacToePlayer
        switch p1Type {
        case "random":
            p1 = RandomPlayer(name: "Random AI 1", piece: .x)
        case "minimax":
            p1 = MinimaxPlayer(name: "Minimax AI 1", piece: .x)
        case "human":
            p1 = HumanPlayer(name: "Human 1", piece: .x)
        default:
            fatalError("Unsupported player 1 type")
        }
        
        // Instantiate player 2
        let p2: TicTacToePlayer
        switch p2Type {
        case "random":
            p2 = RandomPlayer(name: "Random AI 2", piece: .o)
        case "minimax":
            p2 = MinimaxPlayer(name: "Minimax AI 2", piece: .o)
        case "human":
            p2 = HumanPlayer(name: "Human 2", piece: .o)
        default:
            fatalError("Unsupported player 2 type")
        }
        
        let runner = GameRunner(player1: p1, player2: p2, totalGames: games)
        runner.run()
    }
}
