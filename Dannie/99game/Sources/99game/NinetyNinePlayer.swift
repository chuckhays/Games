import Foundation

public protocol NinetyNinePlayer: AnyObject {
    var name: String { get }
    var seatIndex: Int { get set }

    func beginNewGame(state: GameState, seatIndex: Int)
    func requestMove() -> Move
}

public class NinetyNinePlayerBase: NinetyNinePlayer {
    public let name: String
    public var seatIndex: Int = 0
    private var currentState: GameState?

    public var total: Int { state.total }
    public var playDirection: Int { state.playDirection }
    public var drawPileCount: Int { state.drawPileCount }
    public var discardTop: Card? { state.discardTop }
    public var myHand: [Card] { state.myHand }
    public var myHandCount: Int { state.myHandCount }
    public var opponentHandCounts: [Int] { state.opponentHandCounts }
    public var activeSeatIndex: Int { state.activeSeatIndex }
    public var isMyTurn: Bool { state.isMyTurn }
    public var playerNames: [String] { state.playerNames }

    private var state: GameState {
        guard let currentState else {
            fatalError("Player \(name) has not been initialized. Call beginNewGame() first.")
        }
        return currentState
    }

    public init(name: String) {
        self.name = name
    }

    public func beginNewGame(state: GameState, seatIndex: Int) {
        self.currentState = state
        self.seatIndex = seatIndex
    }

    public func legalMoves() -> [Move] {
        state.legalMoves()
    }

    public func requestMove() -> Move {
        fatalError("Subclasses must override requestMove()")
    }
}
